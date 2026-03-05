# Structure conseillé pour ce genre de travail : 

```PlainText

mon-projet-app/
├── backend/            # Code Node.js (API)
│   ├── Dockerfile
│   ├── package.json
│   └── src/
├── frontend/           # Code Angular
│   ├── Dockerfile
│   ├── package.json
│   └── src/
├── docker-compose.yml  # Le chef d'orchestre
├── md
│   ├── architecture
│   └── logic
└── .gitignore

```

# tres important pour le docker compose up -d: `{docker-compose.yml}`

```yml
services:
  # La base de données SQL Server
  db:
    image: mcr.microsoft.com/mssql/server:2022-latest
    container_name: sql_db
    user: root # Important sur Linux pour les permissions de fichiers
    environment:
      - ACCEPT_EULA=Y
      - MSSQL_SA_PASSWORD=Palpatine#12
      - MSSQL_PID=Developer
    ports:
      - "1433:1433"
    volumes:
      - ./mssql_data:/var/opt/mssql
```
> _Explication de la structure de la création de docker-compose.yml_ : 
1. Hiérarchie : généralement les fichier yml suivent tous le même patern : les `{indentation(les espaces)}` 
   
   * -> c-a-d je place le titre en premier ,ceux qui se trouve donc a droite appartienne a ce titre regarde l'exemple en haut 
   * `services:` : pts de départ("docker voici les listes des conteneur(machine virtuelle) que je veux créer")
   * `db:` : nom du service tu aurais pu mettre `database` que cela aurait quand même fonctionné

2. Instruction : a droite sous db ou database selon ton envie

    * image: : C'est le logiciel à installer. Imagine que c'est un DVD d'installation Windows ou Linux tout prêt, stocké sur Internet chez Microsoft.
    * container_name: : C'est le nom qui s'affichera dans Docker Desktop ou ton terminal. Ici, c'est sql_db : pouquoi tu fais `{docker exec -u0 -it oracle bash}` oracle tu le change en sql_db et cela fonctionne .
    * user: root : "`_Docker donne les pleins pouvoirs à ce service pour qu'il puisse écrire des fichiers sur mon disque dur sans erreur de permission_`".

3. La communication et le stockage (Le plus important)
    * ports: - "1433:1433" : 
    
    {`Le chiffre de gauche est la porte de ton vrai PC (Linux).`} 
    {`Le chiffre de droite est la porte à l'intérieur du conteneur.`}
Traduction : "Si quelqu'un frappe à la porte 1433 de mon PC, envoie-le directement à la porte 1433 du conteneur SQL".

    * volumes: - ./mssql_data:/var/opt/mssql : `disque dur externe`.
Par défaut, si un conteneur meurt, tout ce qu'il contient est supprimé.
Traduction : "Prends mon dossier local ./mssql_data et fusionne-le avec le dossier /var/opt/mssql à l'intérieur du conteneur". Tes données sont ainsi sauvegardées sur ton vrai disque.

4. L'environnement (environment:) Ce sont les réglages que l'on passe au logiciel au moment où il s'allume :

    * ACCEPT_EULA=Y : Tu acceptes le contrat de licence Microsoft (obligatoire pour que le serveur démarre).
    * MSSQL_SA_PASSWORD : Tu définis le mot de passe du super-utilisateur (sa veut dire System Administrator).



# Préparation de la structure finale 

## {coté back end avec Nodejs}
1. ouvre un terminal dans Visual Studio Code et tape les codes dans ce script
```bash
# On crée le dossier et on entre dedans
mkdir backend && cd backend

# On initialise le projet Node (crée le package.json)
npm init -y

# On installe les outils nécessaires :
# express : pour créer le serveur web
# mssql : pour parler à SQL Server
# cors : pour autoriser Angular à appeler le backend
# dotenv : pour cacher ton mot de passe Palpatine#12
npm install express mssql cors dotenv
```

2. 