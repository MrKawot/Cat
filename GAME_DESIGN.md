# Prototype : L'épreuve du Gardien

Une salle fermée de la Forêt des Murmures. Le Gardien Écarlate affronte six esprits de ronces. Le combat doit récompenser les placements et les attaques manuelles. Aucune progression permanente dans ce prototype.

## Paramètres initiaux

| Élément | Valeur |
| --- | --- |
| Vie guerrier | 100 |
| Vitesse monde | 260 unités/s |
| Combo | 18 / 18 / 29,7 dégâts |
| Intervalle attaque | 0,28 / 0,28 / 0,46 s |
| Fenêtre combo | 1,05 s |
| Portée normale | 145 unités monde |
| Esquive | 0,24 s à 1050 unités/s |
| Invulnérabilité esquive | 0,19 s |
| Récupération esquive | 0,85 s depuis le déclenchement |
| Charge éveil | dégâts effectifs × 0,6 + 8 par ennemi vaincu |
| Titan | 12 s, dégâts × 1,8, portée × 1,5, dégâts reçus × 0,65 |
| Ennemi mêlée | 65 PV, vitesse 112, dégâts 13 |
| Préparation attaque ennemie | 0,75 s |
| Récupération ennemie | 0,85 s |

Un seul ennemi peut préparer son attaque à la fois. La cible est figée lors de la préparation : se déplacer permet d'éviter le coup. Les coups infligent recul et interruption. Un bref délai après dégâts évite les dégâts empilés au même instant. Les nombres sont provisoires.

## Coordonnées et états

Simulation en XY cartésien borné, rendu `(x-y, (x+y)/2) × 0,85` puis translation. Entrées écran inversées avant déplacement, analogie conservée. Obstacles circulaires, déplacements subdivisés en segments de 12 unités pour éviter de traverser un obstacle lors d'une esquive. Tri des acteurs et obstacles selon leur pied à l'écran. Caméra fixe cadrant toute la salle ; suivi reporté aux salles plus grandes.

Joueur : Idle, Move, Attack, Dodge, Hurt, Dead utilisés ; Cast/Transform réservés aux étapes suivantes. Forme orthogonale Normal/Ultimate, avec transitions gardées (jauge complète, joueur vivant, forme normale). La transformation ne verrouille pas les commandes, ne se recharge pas pendant son activation et expire automatiquement. Mort annule la forme.

Ennemi : Spawn, Seek, Approach, Windup, Attack, Recover, Stun, Dead. Poursuite directe avec collision, sans navigation complexe pour cette salle. La sélection de cible pondère distance et direction et exclut les ennemis trop éloignés ou derrière. Les attaques restent possibles sans cible.

## Direction artistique cible

Guerrier roux, armure argentée, cape/écharpe rouge, épée, bouclier à patte. Les sept planches jointes varient sur certains autres archétypes ; le roster textuel est conservé pour les phases suivantes. Le prototype représente uniquement le guerrier. La taille et l'aura changent lors de l'ultime ; une nouvelle tenue et une animation finale dédiée restent nécessaires.
