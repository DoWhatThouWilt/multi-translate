from translatepy import Translator, Language
translator_instance = Translator()

def translate(word, lang):
    if isinstance(word, bytes):
        word = word.decode("utf-8")

    if isinstance(lang, bytes):
        lang = lang.decode("utf-8")

    translated = translator_instance.translate(word, lang)
    return f"{Language(lang).name}: {translated.result}"
