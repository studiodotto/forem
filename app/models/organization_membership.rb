class OrganizationMembership < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :organization
  belongs_to :collaborator, foreign_key: :collaborator_id, class_name: "User", optional: true

  USER_TYPES = %w[admin member guest collaborator].freeze

  validates :organization_id, :type_of_user, presence: true
  validates :user_id, uniqueness: { scope: :organization_id }, allow_nil: true
  validates :collaborator_id, uniqueness: { scope: :organization_id }, allow_nil: true
  validates :type_of_user, inclusion: { in: USER_TYPES }

  after_create  :update_user_organization_info_updated_at
  after_destroy :update_user_organization_info_updated_at
  after_save    :upsert_chat_channel_membership

  def update_user_organization_info_updated_at
    if self.user_id.present?
      user.touch(:organization_info_updated_at)
    end
  end

  private

  def upsert_chat_channel_membership
    if self.user_id.present?
      return if type_of_user == "guest"

      role = type_of_user == "admin" ? "mod" : "member"
      name = "@#{organization.slug} private group chat"
      channel = ChatChannel.find_by(channel_name: name)

      channel ||= ChatChannels::FindOrCreate.call("invite_only", "#{organization.slug}-private-group-chat", name)

      add_chat_channel_membership(user, channel, role)
    end
  end

  def add_chat_channel_membership(user, channel, role)
    if self.user_id.present?
      membership = ChatChannelMembership.find_or_initialize_by(user_id: user.id, chat_channel_id: channel.id)
      membership.role = role
      membership.save
    end
  end
end
