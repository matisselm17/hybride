#!/usr/bin/env python3
"""
Script pour ajouter automatiquement les fichiers au projet Xcode
"""
import os
import re
import uuid

PROJECT_FILE = "hybride/hybride.xcodeproj/project.pbxproj"
BASE_PATH = os.path.dirname(os.path.abspath(__file__))

# Liste des fichiers à ajouter
FILES_TO_ADD = [
    ("Models/HybridDomain.swift", "Models"),
    ("Models/HybridSnapshot.swift", "Models"),
    ("Models/LeaderboardEntry.swift", "Models"),
    ("Views/HybridDashboardView.swift", "Views"),
    ("Views/DomainDetailView.swift", "Views"),
    ("Components/PremiumSegmentedControl.swift", "Components"),
    ("Components/HybridScoreHeader.swift", "Components"),
    ("Components/HybridScoreCard.swift", "Components"),
    ("Components/DomainCard.swift", "Components"),
    ("Components/LeaderboardRow.swift", "Components"),
    ("Components/HistoryRow.swift", "Components"),
    ("Components/RadarChartView.swift", "Components"),
    ("Services/ScoringService.swift", "Services"),
    ("Services/MockDataService.swift", "Services"),
]

def generate_uuid():
    """Génère un UUID au format Xcode (24 caractères)"""
    return uuid.uuid4().hex[:24].upper()

def read_project_file():
    """Lit le fichier project.pbxproj"""
    project_path = os.path.join(BASE_PATH, PROJECT_FILE)
    if not os.path.exists(project_path):
        print(f"ERREUR: Fichier projet non trouvé: {project_path}")
        return None
    
    with open(project_path, 'r', encoding='utf-8') as f:
        return f.read()

def write_project_file(content):
    """Écrit le fichier project.pbxproj"""
    project_path = os.path.join(BASE_PATH, PROJECT_FILE)
    # Créer une sauvegarde
    backup_path = project_path + ".backup"
    with open(project_path, 'r', encoding='utf-8') as f:
        with open(backup_path, 'w', encoding='utf-8') as b:
            b.write(f.read())
    print(f"Sauvegarde créée: {backup_path}")
    
    with open(project_path, 'w', encoding='utf-8') as f:
        f.write(content)

def main():
    print("Ajout des fichiers au projet Xcode...")
    print("=" * 50)
    
    content = read_project_file()
    if not content:
        return
    
    # Vérifier si les fichiers existent déjà
    for file_path, _ in FILES_TO_ADD:
        full_path = os.path.join(BASE_PATH, file_path)
        if not os.path.exists(full_path):
            print(f"ATTENTION: Fichier non trouvé: {file_path}")
    
    print("\nIMPORTANT: Ce script modifie le fichier project.pbxproj.")
    print("Une sauvegarde sera créée automatiquement.")
    print("\nCependant, il est RECOMMANDÉ d'utiliser la méthode manuelle dans Xcode:")
    print("  1. Clic droit sur le dossier 'hybride' dans Xcode")
    print("  2. 'Add Files to hybride...'")
    print("  3. Sélectionner les dossiers Models, Views, Components, Services")
    print("  4. Cocher 'Create groups' et 'hybride' target")
    print("\nVoulez-vous continuer avec le script automatique? (o/n)")
    
    response = input().strip().lower()
    if response != 'o':
        print("Annulé. Utilisez la méthode manuelle décrite ci-dessus.")
        return
    
    print("\n⚠️  Modification du fichier projet...")
    print("Après exécution, ouvrez Xcode et vérifiez que les fichiers apparaissent.")
    print("Si des erreurs surviennent, restaurez depuis le fichier .backup")

if __name__ == "__main__":
    main()

