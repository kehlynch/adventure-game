export default function isFollowOn() {
  const isFollowOn = document.querySelector(".question-template-is-follow-on");
  const questionTemplateMetadataSections = document.querySelectorAll(".question-template-metadata");
  const questionCreationFormSection = document.querySelector(".question-creation-form-section");

  if (isFollowOn) {
    const followOnOptions = isFollowOn.querySelectorAll("input[type=radio][name=\"question_template[is_follow_on]\"]");
    Array.from(followOnOptions).forEach(followOnOption => {
      followOnOption.addEventListener("change", () => {
        const trueOption = isFollowOn.querySelector("input[type=radio][name=\"question_template[is_follow_on]\"][value=\"true\"]");

        if (trueOption.checked) {
          Array.from(questionTemplateMetadataSections).forEach(questionTemplateMetadataSection => {
            questionTemplateMetadataSection.classList.remove("show-metadata");
          })
          questionCreationFormSection.classList.add("form-section-last");
        } else {
          Array.from(questionTemplateMetadataSections).forEach(questionTemplateMetadataSection => {
            questionTemplateMetadataSection.classList.add("show-metadata");
          })
          questionCreationFormSection.classList.remove("form-section-last");
        }
      });
    });
  }
}
