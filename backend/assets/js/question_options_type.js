export default function optionsType() {

  const optionsTypeSelect = document.querySelector(".options-type-select");
  const customOptionsForm = document.querySelector(".custom-options-form");

  if (optionsTypeSelect) {
    optionsTypeSelect.addEventListener("change", () => {
      const optionsType = optionsTypeSelect.value;

      // Show custom options form if options type is custom, otherwise hide it
      if (optionsType == "Custom") { 
        customOptionsForm.classList.add("show-custom-options");
      } else {
        customOptionsForm.classList.remove("show-custom-options");
      }
    });
  }
}
