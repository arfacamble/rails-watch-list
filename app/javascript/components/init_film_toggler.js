const initFilmToggler = () => {
  const checkBoxes = document.querySelectorAll('.switch-button-checkbox');
  if (checkBoxes.length !== 0) {
    checkBoxes.forEach((checkBox) => {
      let form = checkBox.parentElement;
      checkBox.addEventListener('click', () => {
        form.submit();
      })
    })
  };
};

export { initFilmToggler };
