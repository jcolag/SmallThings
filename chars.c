#include <stdio.h>
#include <string.h>

int main(void) {
    char * name = "Person";
    int i;

    for (i = 0; i < strlen(name); i++) {
        printf("%s\n", &name[i]);
    }
}

