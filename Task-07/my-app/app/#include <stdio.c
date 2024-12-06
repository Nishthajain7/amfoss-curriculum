#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Define the structure for expense records
struct Expense {
    int id;
    char name[50];
    char date[15];
    float amount;
};

// Function prototypes
void addRecord(FILE *file);
void retrieveRecords(FILE *file);
void editRecord(FILE *file);
void deleteRecord(FILE *file);
void searchRecord(FILE *file);
void sortRecords(FILE *file);
void performComputations(FILE *file);
int getRecordCount(FILE *file);
void displayMenu();

int main() {
    FILE *file;
    int choice;

    // Open the file in read-write mode
    file = fopen("expenses.dat", "rb+");
    if (file == NULL) {
        // If file doesn't exist, create it
        file = fopen("expenses.dat", "wb+");
        if (file == NULL) {
            printf("Error opening file!\n");
            return 1;
        }
    }

    do {
        displayMenu();
        printf("Enter your choice: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                addRecord(file);
                break;
            case 2:
                retrieveRecords(file);
                break;
            case 3:
                editRecord(file);
                break;
            case 4:
                deleteRecord(file);
                break;
            case 5:
                searchRecord(file);
                break;
            case 6:
                sortRecords(file);
                break;
            case 7:
                performComputations(file);
                break;
            case 8:
                printf("Exiting the program.\n");
                break;
            default:
                printf("Invalid choice! Please try again.\n");
        }
    } while (choice != 8);

    fclose(file);
    return 0;
}

void displayMenu() {
    printf("\n--- Personal Expenses Management System ---\n");
    printf("1. Add Record\n");
    printf("2. Retrieve Records\n");
    printf("3. Edit Record\n");
    printf("4. Delete Record\n");
    printf("5. Search Record\n");
    printf("6. Sort Records\n");
    printf("7. Perform Computations\n");
    printf("8. Exit\n");
}

void addRecord(FILE *file) {
    struct Expense expense;
    fseek(file, 0, SEEK_END);

    printf("Enter ID: ");
    scanf("%d", &expense.id);
    printf("Enter Name: ");
    scanf("%s", expense.name);
    printf("Enter Date (DD/MM/YYYY): ");
    scanf("%s", expense.date);
    printf("Enter Amount: ");
    scanf("%f", &expense.amount);

    fwrite(&expense, sizeof(struct Expense), 1, file);
    printf("Record added successfully.\n");
}

void retrieveRecords(FILE *file) {
    struct Expense expense;
    rewind(file);

    printf("\n--- Expense Records ---\n");
    while (fread(&expense, sizeof(struct Expense), 1, file) == 1) {
        printf("ID: %d, Name: %s, Date: %s, Amount: %.2f\n",
               expense.id, expense.name, expense.date, expense.amount);
    }
}

void editRecord(FILE *file) {
    struct Expense expense;
    int id, found = 0;
    rewind(file);

    printf("Enter the ID of the record to edit: ");
    scanf("%d", &id);

    while (fread(&expense, sizeof(struct Expense), 1, file) == 1) {
        if (expense.id == id) {
            found = 1;
            printf("Enter new Name: ");
            scanf("%s", expense.name);
            printf("Enter new Date (DD/MM/YYYY): ");
            scanf("%s", expense.date);
            printf("Enter new Amount: ");
            scanf("%f", &expense.amount);

            fseek(file, -sizeof(struct Expense), SEEK_CUR);
            fwrite(&expense, sizeof(struct Expense), 1, file);
            printf("Record updated successfully.\n");
            break;
        }
    }

    if (!found) {
        printf("Record with ID %d not found.\n", id);
    }
}

void deleteRecord(FILE *file) {
    struct Expense expense;
    FILE *tempFile;
    int id, found = 0;

    tempFile = fopen("temp.dat", "wb");
    if (tempFile == NULL) {
        printf("Error creating temporary file!\n");
        return;
    }

    printf("Enter the ID of the record to delete: ");
    scanf("%d", &id);

    rewind(file);
    while (fread(&expense, sizeof(struct Expense), 1, file) == 1) {
        if (expense.id != id) {
            fwrite(&expense, sizeof(struct Expense), 1, tempFile);
        } else {
            found = 1;
        }
    }

    fclose(file);
    fclose(tempFile);

    remove("expenses.dat");
    rename("temp.dat", "expenses.dat");

    file = fopen("expenses.dat", "rb+");
    if (!found) {
        printf("Record with ID %d not found.\n", id);
    } else {
        printf("Record deleted successfully.\n");
    }
}

void searchRecord(FILE *file) {
    struct Expense expense;
    int id, found = 0;
    rewind(file);

    printf("Enter the ID of the record to search: ");
    scanf("%d", &id);

    while (fread(&expense, sizeof(struct Expense), 1, file) == 1) {
        if (expense.id == id) {
            printf("ID: %d, Name: %s, Date: %s, Amount: %.2f\n",
                   expense.id, expense.name, expense.date, expense.amount);
            found = 1;
            break;
        }
    }

    if (!found) {
        printf("Record with ID %d not found.\n", id);
    }
}

void sortRecords(FILE *file) {
    struct Expense *expenses;
    struct Expense temp;
    int count, i, j;

    count = getRecordCount(file);
    expenses = (struct Expense *)malloc(count * sizeof(struct Expense));
    rewind(file);

    for (i = 0; i < count; i++) {
        fread(&expenses[i], sizeof(struct Expense), 1, file);
    }

    for (i = 0; i < count - 1; i++) {
        for (j = i + 1; j < count; j++) {
            if (expenses[i].id > expenses[j].id) {
                temp = expenses[i];
                expenses[i] = expenses[j];
                expenses[j] = temp;
            }
        }
    }

    rewind(file);
    for (i = 0; i < count; i++) {
        fwrite(&expenses[i], sizeof(struct Expense), 1, file);
    }

    free(expenses);
    printf("Records sorted by ID successfully.\n");
}

void performComputations(FILE *file) {
    struct Expense expense;
    float total = 0.0, average = 0.0;
    int count = 0;
    rewind(file);

    while (fread(&expense, sizeof(struct Expense), 1, file) == 1) {
        total += expense.amount;
        count++;
    }

    if (count > 0) {
        average = total / count;
    }

    printf("Total Expenses: %.2f\n", total);
    printf("Average Expense: %.2f\n", average);
}

int getRecordCount(FILE *file) {
    int count = 0;
    struct Expense expense;
    rewind(file);

    while (fread(&expense, sizeof(struct Expense), 1, file) == 1) {
        count++;
    }

    return count;
}
