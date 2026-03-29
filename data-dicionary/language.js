async function loadLanguage(lang) {
    const json = document.getElementById(`${lang}`);
    const translations = JSON.parse(json.textContent);

    document.querySelectorAll("[data-i18n]").forEach(el => {
        const key = el.getAttribute("data-i18n");
        el.textContent = translations[key];
    });
}