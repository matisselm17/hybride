# Correction rapide - Ajouter les fichiers à Xcode

## Solution rapide (2 minutes)

### Méthode 1 : Glisser-déposer (Le plus simple)

1. **Ouvrez Xcode** avec votre projet `hybride.xcodeproj`

2. **Dans le navigateur de projet (à gauche)** :
   - Faites un clic droit sur le dossier `hybride` (le dossier bleu avec votre code)
   - Cliquez sur **"Add Files to 'hybride'..."**

3. **Dans la fenêtre qui s'ouvre** :
   - Naviguez vers : `/Users/matisselemao/Desktop/hybride`
   - Sélectionnez **TOUS** les dossiers suivants (maintenez Cmd pour sélectionner plusieurs) :
     - `Models`
     - `Views`
     - `Components`
     - `Services`
   
4. **Options importantes** :
   - ✅ Cochez **"Create groups"** (pas "Create folder references")
   - ✅ Décochez **"Copy items if needed"** (les fichiers sont déjà là)
   - ✅ Cochez **"hybride"** dans "Add to targets"
   
5. Cliquez sur **"Add"**

6. **Vérifiez** : Vous devriez maintenant voir les dossiers dans Xcode :
   ```
   hybride
   ├── Assets.xcassets
   ├── hybrideApp.swift
   ├── ContentView.swift
   ├── Models
   ├── Views
   ├── Components
   └── Services
   ```

7. **Compilez** : Cmd + B

### Méthode 2 : Ajout manuel fichier par fichier

Si la méthode 1 ne fonctionne pas :

1. Dans Xcode, faites un clic droit sur le dossier `hybride`
2. "Add Files to 'hybride'..."
3. Ajoutez chaque dossier un par un (Models, puis Views, etc.)
4. À chaque fois, vérifiez que "Create groups" est coché et "hybride" target est sélectionné

### Vérification

Après avoir ajouté les fichiers, l'erreur "Cannot find 'HybridDashboardView' in scope" devrait disparaître.

Si l'erreur persiste :
1. Fermez Xcode
2. Supprimez le dossier `DerivedData` (si nécessaire)
3. Rouvrez Xcode
4. Clean Build Folder : Shift + Cmd + K
5. Build : Cmd + B


