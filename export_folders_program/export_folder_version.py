import os
import re

def ziskat_verzi_godot():
    # Cesta k souboru (absolutní cesta vzhledem k umístění skriptu)
    soubor_cesta = os.path.abspath(os.path.join(os.path.dirname(__file__), '../project.godot'))
    
    if not os.path.exists(soubor_cesta):
        return f"Soubor nenalezen: {soubor_cesta}"

    try:
        with open(soubor_cesta, 'r', encoding='utf-8') as f:
            for radek in f:
                # Hledáme přesně řádek začínající config/version
                # Ošetřeno pro formáty: config/version="0.2.0" nebo config/version= "0.2.0"
                if radek.strip().startswith('config/version'):
                    # Rozdělíme podle '=' a vyčistíme uvozovky a mezery
                    casti = radek.split('=')
                    if len(casti) > 1:
                        verze = casti[1].strip().replace('"', '')
                        return verze
                        
    except Exception as e:
        return f"Chyba při čtení: {e}"
    
    return "Verze v souboru nenalezena (klíč config/version)"

if __name__ == "__main__":
    verze = ziskat_verzi_godot()
    print(f"Verze je: {verze}")
    verze = 1
    os.makedirs(f'../exported/windows/x86_64/{verze}', exist_ok=True)
    os.makedirs(f'../exported/windows/x86_32/{verze}', exist_ok=True)
    os.makedirs(f'../exported/linux/x86_64/{verze}', exist_ok=True)
    os.makedirs(f'../exported/linux/x86_32/{verze}', exist_ok=True)
    os.makedirs(f'../exported/html/{verze}', exist_ok=True)