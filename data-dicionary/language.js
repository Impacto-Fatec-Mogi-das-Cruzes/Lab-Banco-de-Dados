async function loadLanguage(lang, setCookie = true) {
    const json = document.getElementById(`${lang}`);
    const translations = JSON.parse(json.textContent);

    document.querySelectorAll("[data-i18n]").forEach(el => {
        const key = el.getAttribute("data-i18n");
        el.textContent = translations[key];
    });

    if (setCookie) {
        document.cookie = `lang=${lang};path=/`;
    }
}

function getCookie(name) {
    const cookies = document.cookie.split('; ');
    for (let c of cookies) {
        const [key, value] = c.split('=');
        if (key === name) return decodeURIComponent(value);
    }
    return null;
}

document.addEventListener("DOMContentLoaded", () => {
    const lang = getCookie('lang');
    console.log(lang);
    loadLanguage(lang, false);
});