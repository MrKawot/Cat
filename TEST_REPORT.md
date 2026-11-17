# Vérifications du 16 novembre 2026

Moteur réel : `4.6.3.stable.official.7d41c59c4`, Linux x86_64.

## Exécuté

- Import éditeur headless puis démarrage scène principale : aucun blocage de script après correction de `_ellipse` et des chemins XDG.
- `./tools/run.sh --headless --script tests/test_runner.gd` : **49 contrôles réussis, 0 échec**. Le script retourne 1 en cas d'échec. Trace complète : `docs/test-output.txt`.
- Huit directions, orientation logique, collision des limites et piliers, déplacement subdivisé anti-traversée, inversion des coordonnées isométriques.
- Attaque sans cible, sélection de cible, dégâts réels, absence d'attaque automatique, recharge, trois coups et expiration du combo.
- Esquive, récupération, rejet d'une seconde esquive et fenêtre d'invulnérabilité limitée.
- Charge, refus à 99 %, consommation à 100 %, double activation refusée, durée 12 s, retour normal, réduction de dégâts, annulation à la mort.
- Télégraphie et dégâts ennemis, victoire, défaite, relance, pause/reprise.
- Événements tactiles simulés : amplitude analogique à 50 %, identifiants indépendants, relâchement, joystick et attaque simultanés avec deux doigts.
- Simulation de l'arène à 60 mises à jour/s jusqu'à la défaite d'un joueur immobile.
- Simulation complète avec déplacements/attaques et ultime contre les six ennemis à leurs PV initiaux jusqu'à la victoire. Ce test commande les mécaniques et ne valide pas le chemin complet des événements Android.
- Exécution graphique réelle sous Xorg dummy + OpenGL llvmpipe : accueil, lancement via bouton, commandes clavier déplacement/attaque/esquive et pause. Inspection de captures 1280 × 720 ; capture combat dans `docs/prototype-arena.png`. Ce rendu logiciel n'est pas une mesure de performance Android.

## Non exécuté / incomplet

- Godot 4.7 : absent. Lecture du catalogue de versions GitHub bloquée par le proxy (403). Compatibilité 4.7 non affirmée.
- SDK Android / adb / modèles d'export : absents. Aucun export APK, aucune installation ou validation sur appareil.
- Pas de test de son : aucun audio implémenté.
- Pas de validation d'animations finales : poses vectorielles temporaires uniquement.
- Pas de benchmark FPS, de longue session, de tests tactiles réels ou de différents formats physiques d'écran.
- Sauvegardes, autres chats, boss et progression : non implémentés dans cette phase.

Les simulations vérifient la logique ; les inspections graphiques vérifient un rendu desktop. Elles ne prouvent ni l'ergonomie Android, ni les performances sur téléphone, ni la qualité premium finale.

## Livraison vérifiée

L’archive `CatMorph-phase1.zip` a été contrôlée (CRC, présence non vide du projet, scène, scripts, données et tests), puis extraite dans un dossier neuf. Import Godot et exécution des 49 contrôles réussis dans cette extraction. Les caches et dossiers locaux ne sont pas inclus.

## Export Android ajouté le 16 novembre 2026

Deux APK de débogage signés exportés sous Godot 4.6.3 : ARM64 et universel (ARM32/ARM64/x86_64). Android minimum API 24 (7.0), cible API 36 du modèle officiel. SDK build-tools 35.0.1 et Java 21 utilisés ; export sans Gradle, NDK/CMake inutiles pour cette voie utilisant les bibliothèques précompilées. Outils Google téléchargés en HTTPS et vérifiés contre les empreintes du dépôt XML officiel ; archive de modèles Godot vérifiée avec SHA-512 officiel. SDK installé par extraction officielle après échec réseau du gestionnaire Java.

Contrôles réussis sur chaque APK : signature v2/v3 avec apksigner, alignement APK et bibliothèques natives sur pages 16 Ko avec zipalign, CRC ZIP, identifiant/version/SDK du manifeste, ABIs attendues, présence des scripts/scène, absence de permission INTERNET et exclusion des tests/docs. Les 49 contrôles de gameplay ont été relancés et passent après configuration Android. Détails et SHA-256 dans `docs/APK_BUILD_REPORT.json` et `exports/SHA256SUMS.txt`.

Aucun appareil connecté ni émulateur exécuté : installation, lancement et performances Android ne sont pas déclarés testés. Clé de débogage locale, pas de signature de publication Play Store. Les mentions de SDK absent ci-dessus décrivent la livraison initiale et sont remplacées par ce complément.

## Version graphique 0.2.0

Nouvel atlas RGBA, décor, polices, HUD et effets intégrés. **49 contrôles réussis, 0 échec** après ces changements ; trace `docs/graphics-test-output.txt`. Rendu réel OpenGL llvmpipe inspecté en 1920 × 1080 logique : `docs/screenshots/graphics-title.png`, `graphics-combat.png` et `graphics-titan-staged.png`. Capture Titan préparée avec jauge complète pour revue visuelle, sans la présenter comme un combat réalisé. Source de capture reproductible : `tests/capture_visuals.gd` (nécessite un affichage graphique). Les APK sont exportés en code version 2 et contrôlés dans `docs/APK_BUILD_REPORT_v0.2.0.json`. Aucun test d'installation ou profilage sur téléphone n'est ajouté à ces résultats.
