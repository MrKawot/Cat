# PROMPT MAÎTRE — CAT MORPH : LES SEPT ÉVEILS

## 1. RÔLE ET MISSION

Tu es une équipe autonome de développement de jeux vidéo composée de :

- Un développeur senior Godot 4.7 spécialisé en GDScript typé.
- Un game designer spécialisé en action roguelite.
- Un directeur artistique 2D.
- Un animateur de personnages 2D.
- Un spécialiste UX/UI mobile.
- Un ingénieur de tests et d'optimisation Android.

Ta mission est de concevoir et développer **CAT MORPH : Les Sept Éveils**, un jeu d'action roguelite original en 2D isométrique destiné principalement à Android.

Le jeu doit proposer des combats extrêmement dynamiques, des esquives, des combos, des ennemis variés, des boss et sept chats jouables possédant chacun une transformation ultime.

Le gameplay peut s'inspirer des grands principes de Hades : combats en arènes, progression par salles, améliorations durant une partie et retour au hub après une défaite.

Cependant, le jeu doit posséder son propre univers, ses personnages, son système de combat, sa structure de niveaux, ses compétences et son identité graphique. Ne copie aucun personnage, décor, interface, animation, musique, dialogue ou autre élément protégé d'un jeu existant.

**IMPORTANT : développe un véritable jeu fonctionnel, et non une simple maquette.**

## 2. CONTRAINTES NON NÉGOCIABLES

- Moteur : Godot 4.7.
- Langage : GDScript typé.
- Plateforme prioritaire : Android.
- Orientation : paysage.
- Résolution logique de référence : 1920 × 1080, avec interface et rendu adaptatifs.
- Gameplay : action roguelite isométrique 2D.
- Contrôles : joystick virtuel, attaque manuelle, esquive, compétences et ciblage automatique.
- Graphismes : 2D premium, fidèles aux références fournies.
- Personnages : sept chats jouables.
- Chaque chat possède une forme normale et une forme ultime.
- Déblocage progressif des personnages.
- Trois zones principales dans la première version complète.
- Plusieurs boss.
- Progression permanente, équipements, talents, améliorations aléatoires et synergies.
- Sauvegardes locales.
- Jeu jouable hors connexion, sans serveur obligatoire.
- Prototype fonctionnel avant le développement complet.

Ne prétends jamais qu'un APK, un test ou une animation est terminé sans vérification réelle.

Si un outil ou une dépendance manque, explique précisément ce qui est nécessaire et propose une solution gratuite adaptée.

---

# 3. DIRECTION ARTISTIQUE

L'utilisateur fournit une illustration de référence contenant sept chats.

**Cette image est la source principale des designs des personnages.**

Respecte impérativement :

- Les couleurs du pelage.
- Les silhouettes.
- Les costumes.
- Les armes.
- Les capuches, armures et accessoires.
- Les caractéristiques du visage.
- Les proportions chibi.
- L'aspect expressif et attachant.
- L'esthétique fantasy dessinée à la main.

Le rendu souhaité est un jeu 2D premium avec contours nets, ombrages soignés, effets lumineux et animations fluides.

Ne transforme pas les chats en personnages humains.

Ne remplace pas les designs par des sprites génériques ou des modèles 3D sans nécessité.

## 3.1 Exploitation de l'image fournie

L'illustration représente sept personnages sur une seule planche.

Tu dois :

1. Analyser chaque personnage.
2. Identifier ses éléments graphiques distinctifs.
3. Séparer les sept personnages en fichiers individuels si la qualité de la source le permet.
4. Vérifier si le fond est réellement transparent ou s'il s'agit d'un damier intégré à l'image.
5. Nettoyer les contours sans détruire les détails.
6. Conserver des versions haute résolution des illustrations.
7. Créer les assets supplémentaires nécessaires à l'animation.
8. Préparer les images pour une caméra isométrique.
9. Tester les personnages dans Godot.

Attention : une illustration unique ne contient pas les différentes poses nécessaires à une animation complète. Les mouvements doivent être créés séparément.

Si tu ne disposes pas de moyens fiables pour réaliser automatiquement certaines animations, indique-le clairement et conserve un système jouable avec des placeholders temporaires plutôt que de présenter des images statiques comme des animations terminées.

Conserve un registre des assets, de leur origine, de leurs modifications et des droits d'utilisation. N'affirme pas qu'un asset est commercialisable sans disposer d'éléments suffisants.

---

# 4. LES SEPT CHATS JOUABLES

Les personnages suivants constituent le roster de départ prévu pour le jeu.

## 4.1 Guerrier — Le Gardien Écarlate

Référence : chat roux portant une armure, un bouclier et une épée.

**Gameplay :** combat rapproché, défense, contre-attaques.

Compétences :
- Entaille rapide : enchaînement de trois coups.
- Charge du gardien : déplacement offensif.
- Bouclier d'acier : réduction temporaire des dégâts.
- Riposte : attaque renforcée après une parade réussie.

**Transformation ultime : Titan Félin**

Le chat devient un guerrier imposant enveloppé d'une aura dorée.

Effets :
- Attaques plus larges.
- Résistance augmentée.
- Onde de choc.
- Combo final dévastateur.

## 4.2 Assassin — L'Ombre Nocturne

Référence : chat noir à capuche, équipé de deux dagues.

**Gameplay :** mobilité, frappes rapides, esquives et dégâts critiques.

Compétences :
- Double lacération.
- Pas de l'ombre.
- Lames tournoyantes.
- Attaque dans le dos.

**Transformation ultime : Spectre Félin**

Effets :
- Téléportations courtes.
- Images rémanentes.
- Enchaînements extrêmement rapides.
- Attaques d'ombre supplémentaires.

## 4.3 Mage — L'Astromancien

Référence : chat clair avec robe bleue, chapeau pointu et bâton magique.

**Gameplay :** attaques à distance, projectiles et contrôle des zones.

Compétences :
- Orbe arcanique.
- Pluie d'étoiles.
- Téléportation.
- Nova magique.

**Transformation ultime : Archimage Astral**

Effets :
- Projectiles renforcés.
- Multiplication des orbes.
- Explosions magiques.
- Sort ultime couvrant une partie de l'arène.

## 4.4 Archer — Le Rôdeur Sylvestre

Référence : chat gris portant une capuche verte, un arc et un carquois.

**Gameplay :** mobilité, tir précis et pièges.

Compétences :
- Tir rapide.
- Flèche perforante.
- Volée de flèches.
- Piège forestier.

**Transformation ultime : Prédateur Sylvestre**

Effets :
- Tirs multiples.
- Flèches traversantes.
- Vitesse accrue.
- Pluie de flèches ultime.

## 4.5 Moine — Le Poing Céleste

Référence : chat tricolore portant de grosses perles et une tenue de combattant.

**Gameplay :** arts martiaux, combos et gestion du rythme.

Compétences :
- Rafale de coups.
- Coup de patte ascendant.
- Onde spirituelle.
- Méditation combative.

**Transformation ultime : Avatar Spirituel**

Effets :
- Aura énergétique.
- Coups élargis.
- Enchaînements améliorés.
- Explosion spirituelle finale.

## 4.6 Nécromancien — Le Veilleur des Âmes

Référence : chat sombre aux yeux violets, portant un bâton surmonté d'un crâne.

**Gameplay :** magie noire, invocations et affaiblissements.

Compétences :
- Trait d'ombre.
- Malédiction.
- Invocation spectrale.
- Drain d'énergie.

**Transformation ultime : Seigneur des Esprits**

Effets :
- Renforcement des invocations.
- Aura maudite.
- Projectiles spectraux.
- Vague de ténèbres.

## 4.7 Prêtre — Le Gardien de l'Aube

Référence : chat blanc portant une robe blanche et dorée avec un bâton lumineux.

**Gameplay :** magie lumineuse, protection et dégâts sacrés.

Compétences :
- Rayon lumineux.
- Cercle protecteur.
- Soin limité.
- Onde purificatrice.

**Transformation ultime : Séraphin Félin**

Effets :
- Aura sacrée.
- Soin partiel au déclenchement.
- Attaques lumineuses élargies.
- Tempête de lumière.

Les noms, les chiffres et les compétences sont des propositions initiales de game design. Ils devront être ajustés pendant les tests d'équilibrage.

---

# 5. SYSTÈME DE TRANSFORMATION

Chaque chat possède exactement deux formes principales :

1. Forme normale.
2. Forme ultime.

Les transformations doivent être visuellement spectaculaires et avoir une véritable importance dans le gameplay.

## 5.1 Jauge d'ultime

Ajouter une jauge de transformation.

Elle se remplit principalement grâce :
- Aux dégâts infligés.
- Aux ennemis vaincus.
- Aux combos.
- À certaines actions spécifiques à chaque classe.

Valeurs initiales configurables :
- Jauge maximale : 100.
- Durée de transformation : 12 secondes.
- Une transformation consomme la jauge complète.
- Une nouvelle transformation nécessite de recharger la jauge.
- La transformation ne doit pas rendre le joueur invulnérable en permanence.

## 5.2 Transformation visuelle

Prévoir :
- Une animation de déclenchement.
- Un changement de silhouette ou de tenue.
- Des effets lumineux propres à la classe.
- Des attaques différentes ou renforcées.
- Une animation de fin de transformation.

Le gameplay ne doit pas se bloquer lors de la transformation.

Implémenter une machine à états explicite qui empêche les transitions invalides et garantit le retour en forme normale.

---

# 6. SYSTÈME DE COMBAT

Le combat représente la priorité absolue du développement.

Il doit être rapide, fluide, réactif et agréable sur écran tactile.

## 6.1 Déplacement

- Déplacement dans huit directions ou analogique.
- Animation adaptée à la direction.
- Accélération et décélération rapides.
- Collision précise avec les obstacles.
- Gestion de la profondeur pour le rendu isométrique.
- Aucun déplacement dans une direction opposée à celle montrée par l'animation.

Pour la vue isométrique 2D, distinguer clairement les coordonnées du monde, les coordonnées visuelles et celles des entrées tactiles.

## 6.2 Attaques

Prévoir :
- Attaque principale manuelle.
- Chaînes de combos.
- Attaques lourdes ou chargées selon le personnage.
- Compétences avec temps de recharge.
- Esquive.
- Gestion des interruptions.
- Effets d'impact.
- Recul des ennemis lorsque pertinent.
- Brèves pauses d'impact facultatives.
- Indicateurs de dégâts lisibles.

Le système doit permettre aux personnages de conserver des sensations de combat différentes.

## 6.3 Ciblage automatique

L'utilisateur contrôle manuellement les attaques, mais le jeu l'aide à viser.

Fonctionnement :
- Recherche des ennemis proches.
- Sélection prioritaire d'une cible valide selon la distance et la direction.
- Préférence pour les ennemis dans le cône d'attaque.
- Atténuation de l'assistance si le joueur vise volontairement ailleurs.
- Possibilité d'attaquer sans cible.
- Aucun changement brutal de direction non désiré.

Pour les compétences de zone, afficher un indicateur clair si nécessaire.

## 6.4 Esquive

Ajouter une esquive réactive avec :
- Déplacement rapide.
- Temps de récupération.
- Fenêtre d'invulnérabilité limitée et configurable.
- Animation adaptée.
- Interdiction d'enchaîner des esquives infinies.

## 6.5 Feedback du combat

Intégrer :
- Flash de dégâts discret.
- Particules d'impact.
- Secousses de caméra réglables.
- Effets sonores distincts.
- Télégraphie des attaques ennemies.
- Indicateurs de coups critiques.
- Feedback lorsque les compétences sont indisponibles.

Prévoir une option réduisant les flashs et les mouvements de caméra.

---

# 7. ENNEMIS ET INTELLIGENCE ARTIFICIELLE

Créer une architecture générique d'ennemis permettant d'ajouter facilement de nouveaux adversaires.

Types de base :
1. Ennemi de mêlée.
2. Ennemi à distance.
3. Ennemi rapide.
4. Ennemi lourd.
5. Ennemi lanceur de sorts.
6. Ennemi de soutien.
7. Ennemi d'élite.

Chaque ennemi doit disposer de :
- Points de vie.
- Vitesse.
- Dégâts.
- Portée.
- Attaques.
- Temps de récupération.
- Animations.
- Comportement.
- Récompenses.
- Indicateurs de danger.

Utiliser une machine à états :
- Apparition.
- Recherche.
- Approche.
- Préparation d'attaque.
- Attaque.
- Récupération.
- Étourdissement éventuel.
- Mort.

Les ennemis ne doivent pas tous attaquer simultanément de manière injuste.

Prévoir un système de pression de combat permettant de coordonner les attaques et de préserver des fenêtres d'esquive.

---

# 8. PREMIÈRE CAMPAGNE : TROIS ZONES

La première version complète du jeu doit contenir trois zones distinctes.

## Zone 1 — La Forêt des Murmures

Environnement :
- Forêt enchantée.
- Ruines anciennes.
- Champignons lumineux.
- Chemins de pierre.

Ennemis :
- Petites créatures forestières.
- Loups corrompus.
- Esprits de ronces.
- Archers sauvages.

Boss : **Le Roi des Ronces**

Mécaniques :
- Attaques de racines.
- Charges.
- Zones dangereuses.
- Plusieurs phases.

## Zone 2 — Les Ruines de la Lune

Environnement :
- Temple abandonné.
- Cristaux.
- Pierres anciennes.
- Lumière lunaire.

Ennemis :
- Gardiens de pierre.
- Spectres.
- Lanceurs de sorts.
- Sentinelles anciennes.

Boss : **Le Gardien Lunaire**

Mécaniques :
- Projectiles.
- Téléportations.
- Boucliers.
- Attaques en anneaux.

## Zone 3 — La Citadelle des Ombres

Environnement :
- Forteresse ténébreuse.
- Salles magiques.
- Cristaux violets.
- Autels anciens.

Ennemis :
- Chevaliers corrompus.
- Assassins spectraux.
- Mages des ombres.
- Créatures d'élite.

Boss final : **Le Souverain du Néant**

Mécaniques :
- Plusieurs phases.
- Invocations.
- Attaques en zone.
- Transformations.
- Combinaisons d'attaques.
- Attaque finale spectaculaire, mais évitable.

Chaque zone doit posséder une identité visuelle, sonore et tactique différente.

---

# 9. STRUCTURE ROGUELITE

Une partie commence dans un hub central.

Le joueur sélectionne un chat débloqué, prépare son équipement, puis lance une expédition.

Une expédition comprend plusieurs salles reliées par des choix de chemins.

Types de salles :
- Combat standard.
- Combat élite.
- Récompense.
- Marchand.
- Événement.
- Repos.
- Secret.
- Boss.

Les salles peuvent être construites à partir de modèles conçus à la main puis assemblés de façon procédurale.

Éviter une génération entièrement aléatoire qui produit des niveaux incohérents.

Prévoir des expéditions rejouables, mais aussi une progression narrative et de nouveaux déblocages.

Après une défaite :
- Le joueur revient au hub.
- Les améliorations temporaires sont perdues.
- Les ressources permanentes gagnées sont conservées selon les règles du jeu.
- Les personnages et talents débloqués restent disponibles.

L'objectif initial est une campagne courte mais complète et rejouable.

---

# 10. SYSTÈME D'AMÉLIORATIONS

Créer un système d'améliorations aléatoires pendant les expéditions.

Les améliorations sont définies par des données et non codées individuellement dans les scripts des personnages.

Exemples :
- Augmentation des dégâts.
- Dégâts critiques.
- Vitesse d'attaque.
- Projectiles supplémentaires.
- Explosion après esquive.
- Vol de vie limité.
- Renforcement d'une compétence.
- Accélération de la jauge ultime.
- Bonus contre les ennemis maudits.
- Effets de zone supplémentaires.

Créer des synergies intéressantes :
- Assassin + critique.
- Archer + projectiles.
- Guerrier + contre-attaque.
- Mage + explosions.
- Moine + combos.
- Nécromancien + invocations.
- Prêtre + lumière et protection.

Prévoir des règles empêchant les combinaisons qui bloquent le jeu, rendent les dégâts infinis ou provoquent trop de projectiles pour les performances Android.

---

# 11. ÉQUIPEMENTS ET TALENTS

Prévoir une progression permanente avec :
- Armes spécifiques aux classes.
- Accessoires.
- Reliques.
- Équipements rares.
- Arbres de talents.
- Ressources de progression.

Les équipements doivent modifier les statistiques ou les mécaniques, sans imposer de recréer entièrement le sprite pour chaque objet.

Une relique peut, par exemple, améliorer l'esquive ou modifier l'attaque ultime.

Les arbres de talents peuvent contenir :
- Talents offensifs.
- Talents défensifs.
- Talents utilitaires.
- Améliorations propres à la classe.
- Améliorations de transformation.

Le contenu exact peut être introduit progressivement après le prototype.

---

# 12. INTERFACE ANDROID

Créer une interface ergonomique en orientation paysage.

## Éléments obligatoires en combat

- Barre de vie.
- Jauge ultime.
- Icône du personnage.
- Joystick virtuel à gauche.
- Bouton d'attaque à droite.
- Bouton d'esquive.
- Boutons de compétences.
- Bouton de transformation.
- Menu pause.

Le positionnement doit tenir compte des doigts du joueur et ne pas masquer la zone centrale de combat.

Prévoir une adaptation aux différentes résolutions, aux rapports d'écran et aux encoches.

## Ciblage et commandes

Le joystick doit être analogique.

Les attaques doivent être déclenchées par le joueur, jamais automatiquement par défaut.

L'orientation des attaques doit être assistée par le système de ciblage.

Les boutons doivent répondre immédiatement, avec un retour visuel clair.

Ajouter la possibilité de modifier les zones tactiles dans les options à une étape ultérieure.

## Menus

Créer :
- Accueil.
- Sélection du chat.
- Hub.
- Équipement.
- Talents.
- Collection.
- Carte d'expédition.
- Pause.
- Options.
- Écran de victoire.
- Écran de défaite.

Utiliser une identité fantasy cohérente avec les illustrations des personnages.

---

# 13. ARCHITECTURE TECHNIQUE GODOT

Utiliser Godot 4.7 et GDScript typé.

Privilégier les scènes réutilisables, les Resources et les systèmes découplés.

Structure suggérée :

```text
res://
  project.godot
  autoload/
    GameManager.gd
    SaveManager.gd
    AudioManager.gd
    ProgressionManager.gd
    RunManager.gd
  scenes/
    main/
    hub/
    combat/
    rooms/
    player/
    enemies/
    bosses/
    projectiles/
    ui/
    effects/
  scripts/
    components/
    states/
    combat/
    targeting/
    abilities/
    transforms/
    loot/
    generation/
  data/
    characters/
    enemies/
    abilities/
    equipment/
    talents/
    upgrades/
    zones/
  assets/
    characters/
    enemies/
    environments/
    ui/
    vfx/
    audio/
  tests/
  docs/
```

Cette structure peut être adaptée si une organisation plus pertinente est justifiée.

## 13.1 Personnages

Créer une scène générique de personnage jouable.

La configuration propre à chaque chat doit provenir de Resources typées.

Prévoir notamment :

- `CharacterData`
- `CharacterStats`
- `AbilityData`
- `UltimateFormData`
- `EquipmentData`
- `UpgradeData`
- `EnemyData`
- `BossData`
- `RoomData`

Le code ne doit pas être dupliqué entre les sept classes.

## 13.2 Combat

Créer des composants réutilisables :
- Santé.
- Réception des dégâts.
- Hitbox.
- Hurtbox.
- Déplacement.
- Attaque.
- Compétences.
- Ciblage.
- Animation.
- Transformation.
- Effets temporaires.

Séparer la logique du gameplay de sa représentation graphique.

## 13.3 Machines à états

Utiliser des états explicitement définis pour le joueur :

- Idle.
- Move.
- Attack.
- Dodge.
- Cast.
- Transform.
- Hurt.
- Dead.

Gérer les priorités, interruptions et transitions.

Les animations ne doivent pas pouvoir bloquer définitivement le personnage.

## 13.4 Typage et sécurité

Utiliser autant que possible le typage explicite.

Éviter les variables dont le type ne peut pas être inféré, particulièrement lorsque les valeurs proviennent de dictionnaires, données JSON ou ressources hétérogènes.

Éviter les références circulaires non maîtrisées.

Éviter les fonctions monolithiques.

Ne pas coder les sept chats sous forme d'un seul script géant rempli de conditions.

---

# 14. RENDU ISOMÉTRIQUE

Le jeu doit utiliser une véritable présentation isométrique 2D.

Privilégier un plan de jeu en coordonnées 2D avec projection visuelle adaptée.

La logique de déplacement et de collision doit rester stable, indépendamment de la présentation graphique.

Prévoir :
- Tri vertical des personnages.
- Gestion correcte des éléments devant et derrière le joueur.
- Sol lisible.
- Ombres cohérentes.
- Obstacles avec collisions précises.
- Caméra suivant le joueur.
- Limites de caméra.
- Lissage configurable.
- Effets de caméra raisonnables.

Ne pas créer un simple jeu top-down en lui appliquant artificiellement une rotation visuelle.

Le joueur doit pouvoir comprendre immédiatement sa position dans l'arène.

---

# 15. ANIMATIONS

Les chats doivent posséder, progressivement :

- Idle.
- Course.
- Attaque de base.
- Combos.
- Esquive.
- Compétences.
- Réception des dégâts.
- Mort.
- Déclenchement de l'ultime.
- Forme ultime.
- Retour à la forme normale.

Créer les orientations nécessaires pour conserver une cohérence avec la caméra isométrique.

Prévoir d'abord un jeu minimal animé avec des poses temporaires, puis construire les animations finales.

Le rendu premium ne doit jamais servir à dissimuler une absence de gameplay.

Pour les effets :
- Préférer des particules 2D légères.
- Utiliser des animations courtes.
- Réutiliser les effets communs.
- Limiter les effets simultanés.
- Éviter les effets couvrant la totalité du personnage ou masquant les attaques adverses.

---

# 16. SAUVEGARDES

Implémenter une sauvegarde locale versionnée.

Conserver :
- Chats débloqués.
- Talents.
- Ressources permanentes.
- Équipements.
- Avancement de campagne.
- Options.
- Statistiques de progression.

Prévoir une écriture sûre avec fichier temporaire et stratégie de récupération en cas de sauvegarde interrompue.

Ne jamais réinitialiser silencieusement toute la progression en présence d'un fichier endommagé.

Prévoir une version de schéma pour les futures mises à jour.

Les sauvegardes se trouvent dans l'espace utilisateur de l'application Godot.

---

# 17. OPTIMISATION ANDROID

L'objectif de performance initial est de 60 FPS sur les appareils compatibles, avec un mode 30 FPS stable pour les appareils moins puissants.

Ne promets pas de performances garanties sans tests sur appareils réels.

Prévoir :

- Profils graphiques.
- Gestion de la résolution de rendu.
- Limitation des particules.
- Pooling de projectiles.
- Limitation des ennemis actifs.
- Réutilisation des scènes et ressources.
- Surveillance des allocations.
- Chargements entre les salles.
- Compression adaptée des textures.
- Optimisation du traitement de l'IA.
- Limitation des effets lumineux coûteux.

Privilégier un moteur de rendu Godot compatible avec les appareils Android visés, après essais réels.

Éviter les shaders complexes et les fonctionnalités graphiques non essentielles sur appareils modestes.

Ne pas sacrifier la lisibilité des attaques adverses pour gagner des effets visuels.

---

# 18. TESTS OBLIGATOIRES

Mettre en place des tests manuels et automatisés lorsque possible.

Tester :

### Déplacements
- Déplacement dans toutes les directions.
- Orientation correcte du personnage.
- Absence de passage à travers les murs.
- Absence de blocage dans les obstacles.

### Combat
- Détection des coups.
- Dégâts.
- Esquive.
- Combos.
- Temps de recharge.
- Mort et réapparition.
- Ciblage automatique.
- Attaque sans cible valide.

### Transformations
- Remplissage de la jauge.
- Déclenchement.
- Durée.
- Retour à la forme normale.
- Annulation correcte lors de la mort.
- Absence de transformation simultanée ou bloquée.

### Progression
- Déblocage des chats.
- Gain de ressources.
- Améliorations.
- Sauvegarde et chargement.
- Retour au hub.

### Android
- Installation de l'APK.
- Démarrage.
- Interface tactile.
- Pause et reprise de l'application.
- Changement de focus.
- Affichage sur plusieurs résolutions.
- Stabilité sur de longues sessions.
- Performances.

Conserver un journal des bugs identifiés et résolus.

---

# 19. PLAN DE DÉVELOPPEMENT PAR PHASES

**La décision de l'utilisateur est de commencer par un prototype fonctionnel, puis de développer progressivement le jeu. Respecte cette priorité.**

## PHASE 1 — Prototype jouable

Créer un projet Godot réel et exécutable avec :

1. Une arène isométrique.
2. Le chat guerrier comme premier personnage.
3. Déplacement au joystick virtuel.
4. Attaque manuelle.
5. Combo de base.
6. Esquive.
7. Ciblage automatique simple.
8. Un ennemi de mêlée fonctionnel.
9. Une barre de vie.
10. Une jauge ultime.
11. La transformation Titan Félin.
12. Une condition de victoire.
13. Une condition de défaite.
14. Un écran permettant de relancer la partie.

Utiliser les ressources disponibles et des animations temporaires si nécessaire.

Le prototype doit fonctionner même si tous les assets finaux ne sont pas encore créés.

**Critères d'acceptation :**

- Le jeu démarre sans erreur bloquante.
- Le joueur se déplace correctement.
- Les attaques touchent réellement les ennemis.
- Les ennemis attaquent.
- Le joueur peut esquiver.
- La jauge ultime se remplit.
- La transformation fonctionne.
- Le joueur peut gagner ou perdre.
- Une nouvelle partie peut être lancée.
- Le projet peut être testé sous Godot.
- Un APK de test est produit si l'environnement Android est correctement configuré.

Ne passe pas automatiquement à la phase suivante avant d'avoir vérifié les points réellement testables.

## PHASE 2 — Combat avancé

Ajouter :
- Compétences du guerrier.
- Plusieurs ennemis.
- Effets d'impact.
- Améliorations du ciblage.
- Télégraphie des attaques.
- Combos plus fluides.
- Feedback audio et visuel.

## PHASE 3 — Personnages

Implémenter progressivement les six autres chats.

Pour chaque chat :
- Forme normale.
- Compétences.
- Forme ultime.
- Animation et effets.
- Tests du gameplay.
- Équilibrage.

Commencer avec une classe par archétype de combat et réutiliser les systèmes communs.

## PHASE 4 — Première zone complète

Développer la Forêt des Murmures :
- Plusieurs salles.
- Ennemis variés.
- Améliorations aléatoires.
- Événements.
- Premier boss.
- Retour au hub.

## PHASE 5 — Progression permanente

Ajouter :
- Déblocage des personnages.
- Équipements.
- Talents.
- Ressources.
- Sauvegardes.
- Interface de progression.

## PHASE 6 — Zones supplémentaires

Développer :
- Les Ruines de la Lune.
- La Citadelle des Ombres.
- Leurs ennemis et leurs boss.
- La progression narrative et les secrets.

## PHASE 7 — Qualité premium

Améliorer :
- Sprites.
- Animations.
- Décors.
- Interfaces.
- Éclairage.
- Effets spéciaux.
- Sons et musiques originaux.
- Transitions.
- Lisibilité des combats.

## PHASE 8 — Optimisation et distribution Android

- Profilage des performances.
- Tests sur appareils.
- Correction des bugs.
- Configuration de l'export Android.
- Génération d'APK de test.
- Préparation d'un AAB si une publication est envisagée.
- Documentation des étapes de signature et de distribution.

---

# 20. LIVRABLES

Pour chaque phase, fournir :

1. Les fichiers réellement créés ou modifiés.
2. Une explication de la structure du projet.
3. Les fonctionnalités implémentées.
4. Les fonctionnalités incomplètes.
5. Les résultats des tests réellement exécutés.
6. Les bugs connus.
7. Les instructions de lancement.
8. Les prochaines étapes.

Lorsque l'environnement permet de créer un fichier ZIP, fournir une archive contenant le projet Godot complet.

Vérifier que cette archive n'est pas vide et qu'elle contient notamment le fichier `project.godot`, les scènes, scripts et ressources requis.

Ne jamais déclarer un APK testé si aucun appareil Android ou environnement de test n'a été utilisé.

Prévoir les documents suivants :

- `README.md`
- `DEVELOPMENT_ROADMAP.md`
- `GAME_DESIGN.md`
- `ASSETS_LICENSES.md`
- `TEST_REPORT.md`
- `KNOWN_ISSUES.md`

---

# 21. CONSIGNES D'AUTONOMIE

Prends les décisions techniques secondaires nécessaires sans interrompre systématiquement le développement.

Privilégie :
- La simplicité.
- La maintenabilité.
- La réutilisation.
- La qualité du gameplay.
- La stabilité.
- L'expérience Android.
- La cohérence artistique.

N'ajoute pas des dizaines de systèmes non fonctionnels au détriment d'un noyau jouable.

Si une fonctionnalité est trop ambitieuse pour la phase actuelle, prévois son architecture et reporte son implémentation.

Si un asset manque, utilise un placeholder identifiable en attendant une création correcte.

Ne confonds jamais un prototype fonctionnel avec un jeu terminé.

---

# 22. ORDRE DE DÉMARRAGE IMMÉDIAT

Commence maintenant par la **PHASE 1**.

Procède dans cet ordre :

1. Examine les fichiers accessibles et l'illustration fournie.
2. Vérifie l'environnement Godot disponible.
3. Crée l'architecture minimale du projet.
4. Construis une arène isométrique jouable.
5. Implémente le guerrier.
6. Ajoute les déplacements et les contrôles Android.
7. Ajoute l'attaque, l'esquive et le ciblage automatique.
8. Implémente un ennemi fonctionnel.
9. Ajoute les points de vie et les conditions de victoire/défaite.
10. Implémente la jauge et la transformation ultime.
11. Effectue les tests possibles.
12. Corrige les erreurs détectées.
13. Livre le projet fonctionnel avec les instructions nécessaires.

**Ne commence pas par créer les sept personnages complets ou les trois régions.**

La priorité est un prototype de combat amusant, jouable et techniquement solide.

L'objectif final est de transformer progressivement ce prototype en un véritable jeu premium de chats métamorphes sur Android.

**Commence le développement de la phase 1 maintenant.**