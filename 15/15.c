#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX 20
#define SYMBOLS 2 // a and b

int nfa[MAX][SYMBOLS][MAX];
int nfa_states, final_states[MAX], is_final[MAX];
int dfa[MAX][SYMBOLS];
int dfa_states = 0;
int visited[MAX];
int state_map[MAX][MAX];
int state_map_size[MAX];

int is_same_state(int *a, int size_a, int *b, int size_b) {
    if (size_a != size_b) return 0;
    for (int i = 0; i < size_a; i++) {
        if (a[i] != b[i]) return 0;
    }
    return 1;
}

int state_exists(int *state, int size) {
    for (int i = 0; i < dfa_states; i++) {
        if (is_same_state(state_map[i], state_map_size[i], state, size))
            return i;
    }
    return -1;
}

void add_state(int *state, int size) {
    for (int i = 0; i < size; i++) {
        state_map[dfa_states][i] = state[i];
    }
    state_map_size[dfa_states] = size;
    dfa_states++;
}

void sort(int *arr, int size) {
    for (int i = 0; i < size-1; i++)
        for (int j = i+1; j < size; j++)
            if (arr[i] > arr[j]) {
                int t = arr[i];
                arr[i] = arr[j];
                arr[j] = t;
            }
}

void nfa_to_dfa() {
    int queue[MAX][MAX], front = 0, rear = 0;
    int size;
    
    // Start with state 0 of NFA
    queue[rear][0] = 0;
    state_map[0][0] = 0;
    state_map_size[0] = 1;
    rear++;
    dfa_states = 1;

    while (front < rear) {
        int *curr = queue[front++];
        int curr_size = state_map_size[front - 1];
        int index = front - 1;

        for (int sym = 0; sym < SYMBOLS; sym++) {
            int temp[MAX], temp_size = 0;
            for (int i = 0; i < curr_size; i++) {
                int state = curr[i];
                for (int j = 0; j < nfa_states; j++) {
                    if (nfa[state][sym][j] && !memchr(temp, j, temp_size * sizeof(int))) {
                        temp[temp_size++] = j;
                    }
                }
            }

            sort(temp, temp_size);
            int existing = state_exists(temp, temp_size);
            if (existing == -1) {
                for (int k = 0; k < temp_size; k++)
                    queue[rear][k] = temp[k];
                state_map[dfa_states][0] = temp[0];
                for (int k = 0; k < temp_size; k++)
                    state_map[dfa_states][k] = temp[k];
                state_map_size[dfa_states] = temp_size;
                dfa[index][sym] = dfa_states;
                rear++;
                dfa_states++;
            } else {
                dfa[index][sym] = existing;
            }
        }
    }
}

void print_dfa() {
    printf("\nDFA Transition Table:\n");
    printf("State\ta\tb\n");
    for (int i = 0; i < dfa_states; i++) {
        printf("Q%d\tQ%d\tQ%d\n", i, dfa[i][0], dfa[i][1]);
    }
}

int main() {
    int i, j, k, trans, sym;
    char input_symbol;

    printf("Enter number of states in NFA: ");
    scanf("%d", &nfa_states);

    printf("Enter transitions for each state (on 'a' and 'b'):\n");
    for (i = 0; i < nfa_states; i++) {
        for (sym = 0; sym < SYMBOLS; sym++) {
            printf("Number of transitions from state %d on %c: ", i, sym == 0 ? 'a' : 'b');
            scanf("%d", &trans);
            printf("Enter states: ");
            for (j = 0; j < trans; j++) {
                scanf("%d", &k);
                nfa[i][sym][k] = 1;
            }
        }
    }

    nfa_to_dfa();
    print_dfa();

    return 0;
}