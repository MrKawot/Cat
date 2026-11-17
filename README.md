# CAT MORPH : Les Sept Éveils — 0.2.0

**[Téléchargement des APK sur GitHub](https://github.com/MrKawot/Cat/tree/main/downloads)**

Prototype jouable de phase 1, hors connexion, en GDScript typé. Ce dépôt contient le projet réel, sans dépendance externe. Il ne représente pas le jeu premium terminé.

## Lancer

Ouvrir `project.godot` dans Godot, puis F6 sur `scenes/main.tscn` ou F5. En terminal :

```bash
cd /workspace/Cat # ou le dossier extrait du ZIP
./tools/run.sh --editor --import --headless --quit
./tools/run.sh
```

Le lanceur réserve des dossiers XDG locaux lorsque les variables ne sont pas déjà définies. Godot doit être installé dans le PATH. Premier import obligatoire avant les tests CLI pour enregistrer les classes globales.

**Version réellement utilisée : Godot 4.6.3 stable.** La cible demandée est 4.7, mais cette version n'est pas disponible sur cette machine et n'a pas été validée. L'accès au catalogue GitHub a retourné un refus du proxy. Ne pas considérer la contrainte 4.7 comme satisfaite. Aucune extension native ni fonctionnalité spécifique 4.7 n'est utilisée ; ouvrir, importer et relancer les tests sous 4.7 avant migration.

## Jouer

Cliquer « Entrer dans la forêt ». Vaincre les six esprits de ronces pour gagner. À zéro PV : défaite et possibilité de relancer.

| Action | Clavier | Tactile |
| --- | --- | --- |
| Déplacer | ZQSD, WASD, flèches | Joystick analogique gauche |
| Attaquer | Maintenir J | Maintenir Attaque |
| Esquiver | Espace | Esquive |
| Titan Félin | K | Éveil, jauge à 100 % |
| Pause | Échap | Pause |

Les attaques restent manuelles : seul le maintien d'une commande les répète. L'assistance vise les ennemis devant le joueur. Les cercles rouges annoncent leurs attaques. Le Titan dure 12 secondes, augmente les dégâts et la portée, réduit les dégâts reçus sans rendre invulnérable. Une option réduit les flashs. La perte de focus met le combat en pause. Aucun serveur, compte ou secret n'est requis.

## Vérifier

```bash
./tools/run.sh --headless --script tests/test_runner.gd
```

Résultat vérifié : **49 contrôles, zéro échec** sous Godot 4.6.3. Voir `TEST_REPORT.md` pour les limites de ces tests.

## Structure

- `scenes/main.tscn` : scène exécutable.
- `scripts/arena.gd` : orchestration du combat, cibles, HUD, début/fin de partie.
- `scripts/player.gd` : états du guerrier, combo, esquive, santé et transformation.
- `scripts/enemy.gd` : ennemi de mêlée à états et préparation d'attaque.
- `scripts/iso.gd` : projection et déplacement avec collision subdivisée.
- `scripts/touch_controls.gd` : joystick et commandes de combat multitouch indépendantes.
- `scripts/obstacle.gd` : obstacles avec profondeur d'affichage.
- `data/warrior.tres`, `scripts/character_data.gd` : paramètres typés du guerrier.
- `tests/test_runner.gd` : tests de mécaniques et simulations intégrées.
- `docs/` : cahier des charges, traces et captures de vérification.

## Android

Paysage, référence 1920 × 1080, rendu Compatibility, mise à l'échelle uniforme avec conservation du cadrage. Les commandes multitouch existent, mais ne sont pas validées sur un appareil Android. Deux APK de débogage signés sont générés dans `exports/` (ARM64 et universel ARM32/ARM64/x86_64), Android 7.0 minimum. Signatures, alignement et contenu vérifiés ; installation et jeu sur appareil non testés.

Pour l'export : installer la version Godot retenue et ses modèles d'export correspondants, OpenJDK et Android SDK selon la documentation officielle de cette version ; configurer les chemins dans l'éditeur, ajouter un preset Android, puis exporter un APK de débogage. Le SDK dans `/workspace/android-tools/sdk`, les modèles 4.6.3 et la clé de débogage locale sont maintenant installés. Relancer `./tools/export_android.sh` pour reproduire les deux APK sur cette machine. Vérifier sur appareil les zones sûres, les encoches, le focus, le multitouch, les différentes résolutions et les performances avant toute diffusion.

## Limites

Décor et atlas illustrés intégrés, interface mobile et effets refaits. Poses avant/arrière/frappe et animations procédurales ; cycles dessinés complets, son, sauvegardes, six autres chats et campagne reportés. Voir `docs/GRAPHICS_UPDATE.md`. Les images jointes ont été consultées comme références visuelles, sans extraction ni nettoyage de pixels. Voir `ASSETS_LICENSES.md`, `KNOWN_ISSUES.md` et `DEVELOPMENT_ROADMAP.md`.
