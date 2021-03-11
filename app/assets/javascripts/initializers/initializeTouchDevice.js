function getById(className) {
  return document.getElementById(className);
}
function getClassList(className) {
  return getById(className).classList;
}

function blur(event, className) {
  setTimeout(() => {
    if (document.activeElement !== getById(className)) {
      getClassList('crayons-header__menu').remove('showing');
    }
  }, 10);
}

function removeShowingMenu() {
  getClassList('crayons-header__menu').remove('showing');
  getClassList('crayons-header__menuu').remove('showing');
  setTimeout(() => {
    getClassList('crayons-header__menu').remove('showing');
    getClassList('crayons-header__menuu').remove('showing');
  }, 5);
  setTimeout(() => {
    getClassList('crayons-header__menu').remove('showing');
    getClassList('crayons-header__menuu').remove('showing');
  }, 150);
}

function toggleMenu() {
  getClassList('crayons-header__menu').toggle('showing');
  getClassList('crayons-header__menuu').toggle('showing');
}

function initializeTouchDevice() {
  var isTouchDevice = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini|DEV-Native-ios/i.test(
    navigator.userAgent,
  );
  if (navigator.userAgent === 'DEV-Native-ios') {
    document.body.classList.add('dev-ios-native-body');
  }
  setTimeout(() => {
    removeShowingMenu();
    if (isTouchDevice) {
      // Use a named function instead of anonymous so duplicate event handlers are discarded
      getById('navigation-butt').addEventListener('click', toggleMenu);
      getById('navigation-buttt').addEventListener('click', toggleMenu);
    } else {
      getClassList('crayons-header__menu').add('desktop');
      getById('navigation-butt').addEventListener('focus', (e) =>
        getClassList('crayons-header__menu').add('showing'),
      );
      getById('last-nav-link').addEventListener('blur', (e) =>
        blur(e, 'second-last-nav-link'),
      );
      getById('navigation-butt').addEventListener('blur', (e) =>
        blur(e, 'first-nav-link'),
      );
      getById('navigation-buttt').addEventListener('focus', (e) =>
        getClassList('crayons-header__menu').add('showing'),
      );
      getById('last-nav-link').addEventListener('blur', (e) =>
        blur(e, 'second-last-nav-link'),
      );
      getById('navigation-buttt').addEventListener('blur', (e) =>
        blur(e, 'first-nav-link'),
      );
    }
  }, 10);
}
