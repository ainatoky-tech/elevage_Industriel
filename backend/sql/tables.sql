-- 1. Table des Lots (La base de tout)
CREATE TABLE Lots (
    id_lot INT PRIMARY KEY IDENTITY(1,1),
    date_achat DATE NOT NULL,
    race VARCHAR(100) NOT NULL,
    nombre_initial INT NOT NULL,
    prix_unitaire_gramme DECIMAL(18, 2), -- Prix basé sur la masse
    habitude_alimentaire TEXT,
    est_clos BIT DEFAULT 0 -- 0 = actif, 1 = vendu/fini
);

-- 2. Table Alimentation (Suivi par semaine)
CREATE TABLE Alimentation (
    id_alim INT PRIMARY KEY IDENTITY(1,1),
    id_lot INT FOREIGN KEY REFERENCES Lots(id_lot),
    date_debut_semaine DATE NOT NULL,
    date_fin_semaine DATE NOT NULL,
    quantite_g DECIMAL(18, 2) NOT NULL,
    prix_aliment_n_gramme DECIMAL(18, 2) NOT NULL
);

-- 3. Table Croissance et Santé (Morts et Evolution)
CREATE TABLE SuiviElevage (
    id_suivi INT PRIMARY KEY IDENTITY(1,1),
    id_lot INT FOREIGN KEY REFERENCES Lots(id_lot),
    date_suivi DATE DEFAULT GETDATE(),
    nombre_morts INT DEFAULT 0,
    masse_reelle_g DECIMAL(18, 2), -- Saisie par l'utilisateur
    nombre_vivants INT -- Calculé par Node (Effectif - morts)
);

-- 4. Table Gestion des Couvées (Les oeufs pondus)
CREATE TABLE Couvees (
    id_couvee INT PRIMARY KEY IDENTITY(1,1),
    id_lot_parent INT FOREIGN KEY REFERENCES Lots(id_lot),
    date_ponte DATE DEFAULT GETDATE(),
    nb_oeufs_total INT NOT NULL,
    nb_oeufs_vente INT DEFAULT 0,
    nb_oeufs_elevage INT DEFAULT 0
);

-- 5. Table Eclosions (Pour créer le nouveau lot)
CREATE TABLE Eclosions (
    id_eclosion INT PRIMARY KEY IDENTITY(1,1),
    id_couvee INT FOREIGN KEY REFERENCES Couvees(id_couvee),
    date_eclosion DATE NOT NULL,
    nb_eclos INT NOT NULL,
    id_nouveau_lot INT FOREIGN KEY REFERENCES Lots(id_lot) -- Lien vers le nouveau Lot S0
);