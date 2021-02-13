json.array! @exclusive_articles do |exclusive_article|
  json.type_of "exclusive_contents"

  json.extract!(
      exclusive_article,
      :id,
      :path,
      :cloudinary_video_url,
      :title,
      :user_id,
      :video_duration_in_minutes,
      :video_source_url,
      )

  json.user do
    json.name exclusive_article.user.name
  end

  json.main_image exclusive_article.main_image || 'https://res.cloudinary.com/dyzicyjzq/image/fetch/s--Juz0aGHs--/c_imagga_scale,f_auto,fl_progressive,h_420,q_auto,w_1000/https://studioappbucket.s3.amazonaws.com/i/76nnuqytglg0xahb1k1b.jpg'
end
