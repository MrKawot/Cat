# Registre des assets

| Asset | Origine | Modifications et usage | Droits / statut |
| --- | --- | --- | --- |
| Sept planches de chats jointes | Utilisateur, conversation du 16 novembre 2026 | Références visuelles consultées ; aucun pixel importé dans le jeu | Titularité et autorisation commerciale non documentées ; ne pas conclure à une licence commerciale |
| Guerrier vectoriel | Dessin procédural original dans `scripts/player.gd`, créé pour ce prototype | Pelage roux, armure, écharpe rouge, épée et bouclier ; oscillation, déplacement d'arme, agrandissement et aura | Placeholder original ; pas de licence globale du projet imposée à l'utilisateur |
| Esprits de ronces | Dessin procédural original dans `scripts/enemy.gd` | Déformation simple, flash et télégraphie | Placeholder |
| Arène, obstacles, joystick, interface | Dessins procéduraux originaux dans les scripts | Tuiles projetées, cadres, jauges, cercles | Placeholders |
| Police de secours moteur | `ThemeDB.fallback_font`, distribuée avec Godot | Aucune modification ni copie séparée | Consulter les notices de Godot lors d'une distribution du moteur exporté |
| Son / musique | Aucun | Aucun fichier audio | Non implémenté |

Les illustrations sont visibles dans la conversation mais ne sont pas présentes comme fichiers image dans le workspace. Impossible de vérifier leur canal alpha ou de détourer proprement à partir de ces seuls aperçus. Le damier visible ne prouve pas la transparence : analyser les fichiers sources RGBA avant extraction. Aucune séparation, suppression de fond ou animation issue des planches n'est annoncée comme réalisée. Les animations procédurales du prototype ne remplacent pas des poses directionnelles dessinées.

Les trois fichiers texte joints sont identiques (SHA-256 `1b7c7b3d816f6d2e5b5fc3e429a1299486b4002c4a57b44678d912248513fd76`). Une copie du cahier des charges est conservée dans `docs/USER_BRIEF.md`.

Icône `assets/icon.svg` : dessin vectoriel original de chat roux créé pour identifier les APK, distinct des illustrations jointes ; placeholder.

## Assets graphiques ajoutés en 0.2.0

| Fichier | Origine et traitement | Statut |
| --- | --- | --- |
| `assets/art/forest_atlas.png` | Généré avec l'outil image_gen à partir du brief verbal (guerrier et fantasy forestière), 1536 × 1024 RGBA, six cellules égales. Copie intacte de `generated_images/exec-bbed36bc-18ca-4bf2-a528-47d52e6fe360.png`. Aucun détourage ou rééchantillonnage destructif ; régions sélectionnées par AtlasTexture Godot. | Art généré par IA ; pas d'affirmation de droits commerciaux sur les références. Transparence alpha vérifiée. |
| `assets/art/forest_arena.png` | Généré avec image_gen, 1672 × 941, copie intacte de `generated_images/exec-fffdc07b-fb4d-4689-a365-aa723f9faae7.png`. Cadrage plein écran par Godot. | Art généré par IA, nouveau décor original guidé par le brief. |
| `assets/fonts/Cinzel.ttf` | Dépôt officiel Google Fonts `ofl/cinzel`, fichier variable non modifié. | SIL Open Font License, notice `Cinzel-OFL.txt` incluse. |
| `assets/fonts/OpenSans-Semibold.ttf` | Distribution système `fonts-open-sans`, copie non modifiée. | Notice de distribution `OpenSans-LICENSE.txt` incluse (Apache 2.0). |

Les anciennes lignes « dessin vectoriel placeholder » décrivent la version 0.1.0 : la représentation du guerrier/ennemi/décor est remplacée par les fichiers ci-dessus. L'icône SVG et les icônes de commandes restent vectorielles. Les images utilisateur n'ont pas été détourées ni intégrées pixel pour pixel. Les limites des cycles animés restent documentées dans `docs/GRAPHICS_UPDATE.md`.
