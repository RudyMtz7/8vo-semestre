#include <stdio.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>


#define NITAAAAAAA 1

sem_t emptyPot;
sem_t fullPot;

void *beaaaar (void*);
void *bee (void*);

static pthread_mutex_t servings_mutex;
static pthread_mutex_t print_mutex;

static int servings = 10;

int getServingsFromPot(void) {
    int retVal;

    if (servings <= 0) {
        sem_post (&emptyPot);
        retVal = 0;
    } else {
        servings--;
        retVal = 1;
    }

    pthread_mutex_unlock (&servings_mutex);

    return retVal;
}

void putServingsInPot (int num) {

    servings += num;
    sem_post (&fullPot);

}

void *bee (void *id) {
    int bee_id = *(int *)id;
    int i, pablo_honey, servingsBees = servings;

    while (servingsBees) {

        sem_wait (&emptyPot);

        pablo_honey = rand() % 3 + 1;
        putServingsInPot (pablo_honey);
        servingsBees = servingsBees - pablo_honey;

        pthread_mutex_lock (&print_mutex);
        printf ("Bee added %i portions\n", pablo_honey);
        pthread_mutex_unlock (&print_mutex);

        for (i=0; i<NITAAAAAAA; i++)
            sem_post (&fullPot);

    }

    return NULL;
}

void *beaaaar (void *id) {
    int beaaaar_id = *(int *)id;
    int myServing;
    int servingsBeeeeeaaaar = servings;

    while(servingsBeeeeeaaaar){

        pthread_mutex_lock (&servings_mutex);

        myServing = getServingsFromPot();
        if (servings == 0) {
            sem_wait (&fullPot);
            myServing = getServingsFromPot();
        }

        pthread_mutex_unlock (&servings_mutex);

        servingsBeeeeeaaaar--;

        pthread_mutex_lock (&print_mutex);
        printf ("NITAAAAAAA is eating\n");
        pthread_mutex_unlock (&print_mutex);

        sleep(2);

        pthread_mutex_lock (&print_mutex);
        pthread_mutex_unlock (&print_mutex);
    }

    printf ("NITAAAAAAA is DONE eating\n");

    return NULL;
}


int main(int argc, char const *argv[]) {
  /* code */
  if (argc != 2) {
    printf("usage: %s number_of_bees\n", argv[0]);
    return -1;
  }

  int i, id[NITAAAAAAA+1];
  pthread_t tid[NITAAAAAAA+1];

  // Initialize the mutex locks
  pthread_mutex_init(&servings_mutex, NULL);
  pthread_mutex_init(&print_mutex, NULL);

  // Initialize the semaphores
  sem_init(&emptyPot, 0, 0);
  sem_init(&fullPot,  0, 0);

  for (i=0; i<NITAAAAAAA; i++) {
      id[i] = i;
      pthread_create (&tid[i], NULL, beaaaar, (void *)&id[i]);
  }
  pthread_create (&tid[i], NULL, bee, (void *)&id[i]);

  for (i=0; i<NITAAAAAAA; i++)
      pthread_join(tid[i], NULL);

  return 0;
}
