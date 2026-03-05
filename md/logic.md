# Projet élevage industriel :

*Technologie utilisé : SQLServer , Angular , Nodejs.*


# `Coté backEnd` : Ensemble des besoins(Nodejs)

> **Base de donnée : sql (je suppose)**:
1. table lot :(a supposer identique en age ,race )
    * date d'achat
    * Race(le nom de leur race)
    * nombre a acheter 
    * prix unitaire (ici c'est la masse qui sera l'unité de mesure non le nombre de poulet(poussin))
    * habitude alimentaire pour chaque poulet du lot

2. table gestion des lots(mort et éclosion):
    * effectif
    * nombre de mort
    * date mort
    * nombre d'oeuf éclos
    * lots
    * date d'éclosion

3. table alimentation :
    * prix aliment par n gramme
    * quantité demander 
    * date début semaine
    * date fin semaine

4. table gestion des couvées (les oeufs tous nouvellement pondue)
    * nombre d'oeuf pondu
    * nombre d'oeuf destiné à la vente
    * nombre d'oeuf destiné à l'élevage

> But final : faire une sorte de tableau statistique géant 

Attention: on affiche l'évolution de la masse de ces petits poussin au fil des semaines 
ex : 
- S0 on connait la masse des poussins et c'est tout je suppose
- S1 : masse poulet = masse poulet(S0) + (masse de nourriture(qtt de nourriture en g) /7 jours(donc une semaine) ) 
    `Mais on affiche les masses qu'ils ont prise : masse poulet(S1) - masse poulet(S0) <- voilà ce que l'on affiche au fil des semaines `
.
.
.
- Sn : on vend les poulets qui ne prenne plus de masse 

> Benefice : pas besoin de photo
* *`BENEFICE : (prix achat du lot de poulet + prix de la nourriture total toute race confondu) - (prix vente d'un poulet(mais appliquer au lot **)+ valeur des oeufs)`*
* *les donnés sur la non variation de la masse seront insérer par l'utilisateur*

NOTA BENE :
-
- ** prix vente  d'un poulet (mais appliquer au lot ): on estime le prix d'un poulet puis une fois fait on calcule avec les autres poulets

ex: 1 poulet a pour masse définitivement invariable après N semaine = 1500g 
    l'estimation est de 22000Ar pour ce poulet alors pour un lot comportant 50 poulets ce serait combien en sachant qu'un poulet pèse 1500g et que le poids moyen de tout le lots est de (a calculer sur la masse que le lot pèse ) 




# `Coté frontEnd` : liste des formulaires(Angular) : 
1. un formulaire qui insert les poulets (les lots de départ)
    * date d'acquisition , nombre demandé , race , prix unitaire par n gramme

2. formulaire pour la gestion de l'élevage
    * le nombre de vivant(nombre demandé) 
    * le nombre d'oeuf pondue
    * le nombre de mort
    * habitutde alimentaire

3. formulaire pour la gestion des lots :    
    * nombre de poulet mort
    * quels lots
    * date de déces

4. formulaire de gestion des ventes :
    * nombre d'oeuf déstinée a l'élevage
    * nombre d'oeuf déstinée a la vente

5. formulaire pour la gestion des éclosions:
    * effectif des oeufs 
    * race 
    * combien
    * quel lots

NOTA BENE :
--------------------------------------------------------------- 
* pour l'éclosion chaque oeufs éclos auront un timelaps différent que celui des premiers lots acheter a S0 en gros lorsqu'ils auront éclos ils vont avoir un S0 différent que le S0 que la première génération de poulet achetée

* pour l'éclosion des oeufs ils ne vont pas réintégrés les premiers lots sur lequel ils sont nés mais vont formé un lot différent

* la question a un millions est ce que les nouveaux lot vont ils accueillir les nouveaux oeufs éclos de leur même race ? 