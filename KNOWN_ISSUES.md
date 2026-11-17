# Bugs et limites connus

## Restant à traiter

- Godot 4.7 demandé non installé et non testé ; moteur actuel 4.6.3. La phase 1 n'est donc pas entièrement acceptée sur la cible moteur.
- SDK Android, adb et modèles 4.6.3 installés. Deux APK de débogage générés et signatures vérifiées. Installation, appareil réel et mesures FPS Android restent non testés.
- Art illustré et poses avant/arrière/frappe intégrés en 0.2.0. Animation procédurale, sans cycle complet dessiné par direction, tenue Titan dédiée ni animation dessinée de fin de transformation.
- Pas de sons, de caméra suiveuse, de compétences secondaires, de sauvegardes ou de progression permanente (hors périmètre de cette livraison phase 1).
- Poursuite directe des ennemis ; un ennemi peut rester momentanément coincé derrière un pilier. Les ennemis peuvent se superposer. Ajouter navigation et séparation après validation du combat de base.
- Joystick et boutons multitouch testés par événements simulés uniquement. Ergonomie, zones sûres et encoches à vérifier sur appareils.
- Les messages d'indisponibilité restent affichés jusqu'au prochain message. Équilibrage provisoire, les attaques répétées peuvent interrompre facilement les ennemis.
- Pas de profilage longue durée. La subdivison de mouvement protège les collisions mais les deltas artificiellement immenses ne sont pas un cas de performance validé.

## Résolus et recontrôlés

- Collision de nom avec la méthode native Godot `draw_ellipse` : helper renommé `_ellipse`, import et démarrage sans erreur.
- Dossiers utilisateur non inscriptibles en environnement cloud : lanceur XDG vers des chemins locaux, exécution vérifiée.
- Marges de style imposant une hauteur incorrecte aux jauges : styles de jauges séparés des marges de la fenêtre, capture vérifiée.
- Obstacles toujours derrière les acteurs : nœuds dédiés et tri par profondeur du pied.
- Risque de traversée d'un pilier à grande vitesse : déplacement subdivisé, contrôle automatisé dédié.
- Risque de dépendre de l'émulation souris pour le second doigt : suivi indépendant des identifiants tactiles ; test simultané joystick/attaque et relâchement.

- Résolu en 0.2.0 : portrait HUD agrandi involontairement par la taille minimale de TextureRect. Taille différée et initialisation corrigées, capture contrôlée.
