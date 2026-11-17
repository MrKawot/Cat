# Version 0.2.0 — Forêt des Murmures

## Réalisé

- Décor forestier peint, sol de pierres, mousses, champignons lumineux et lumière d'ambiance. Les limites et collisions restent calculées dans le monde isométrique ; le trait discret de bordure marque la limite réellement jouable.
- Atlas RGBA partagé de six cellules 512 × 512 : guerrier de face, de dos, pose de frappe, esprit de ronces, pierre runique et arbre. Le guerrier conserve pelage roux, armure argentée, cape rouge, épée et bouclier à patte. L'arbre est disponible mais non instancié : le décor contient déjà sa végétation.
- `CatActorArt` sépare la représentation du gameplay : poses avant/arrière selon l'orientation, miroir gauche/droite, respiration, oscillation/squash de course, pose de frappe, arcs de lame, traînées d'esquive, flash modéré et disparition d'ennemi. Titan agrandi, teinte dorée, cercles et étincelles. Ces animations procédurales ne sont pas des cycles dessinés image par image.
- Menus illustrés, polices Cinzel/Open Sans, portrait compact, jauges, joystick à patte et boutons à icônes avec recharge et disponibilité.
- Impacts et lucioles limités en nombre, atlas mutualisé, rendu Compatibility, aucun shader lourd ni lumière temps réel. Aucune garantie de FPS sans profilage mobile.
- Version APK 0.2.0, code 2, même identifiant et même clé de débogage que 0.1.0 pour permettre une mise à jour.

## Vérification

Les 49 contrôles existants passent après modification. Captures réelles du rendu Godot/OpenGL dans `docs/screenshots/` : accueil, combat et Titan. La capture Titan est explicitement préparée avec jauge à 100 dans `tests/capture_visuals.gd` pour inspecter le rendu ; les tests de gameplay vérifient séparément la charge et les conditions d'activation.

Un défaut de taille minimale de TextureRect affichait le portrait HUD à 512 pixels. Ordre d'initialisation et taille différée corrigés ; capture finale inspectée. La transparence du fichier atlas a été vérifiée : canal alpha RGBA, pixels de gouttière à alpha zéro, personnage opaque ; le fond coloré RGB caché n'est pas dessiné.

## Encore nécessaire

Godot 4.7, essai d'installation/tactile sur téléphone, profilage, sprites directionnels supplémentaires, cycles dessinés de course/attaque/mort, tenue Titan dédiée et sons. La structure jouable reste celle du prototype de combat ; aucune campagne, sauvegarde ou collection de sept chats n'est annoncée comme terminée.
