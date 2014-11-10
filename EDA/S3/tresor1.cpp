#include <iostream>
#include <vector>


//borrar std



bool busca(int posicio_y, int posicio_x, int size_x, int size_y, const std::vector< std::vector<char> > & mapa, std::vector< std::vector<bool> > & visitable){
   if (posicio_y < 0 or posicio_y >= size_y or posicio_x < 0 or posicio_x >= size_x or (not visitable[posicio_y][posicio_x])) return false;
   visitable[posicio_y][posicio_x] = false;
   if(mapa[posicio_y][posicio_x ] == 't') return true;
   return(busca(posicio_y+1, posicio_x, size_x, size_y, mapa, visitable) or
          busca(posicio_y-1, posicio_x, size_x, size_y, mapa, visitable) or
          busca(posicio_y, posicio_x+1, size_x, size_y, mapa, visitable) or
          busca(posicio_y, posicio_x-1, size_x, size_y, mapa, visitable));
}

void get_size(int & size_x, int & size_y){
    std::cin >> size_x >> size_y;
}

int main(){
    int size_x;
    int size_y;
    int posicio_x;
    int posicio_y;
    get_size(size_x, size_y);
    std::vector< std::vector<char> > mapa (size_y, std::vector<char> (size_x) );
    std::vector< std::vector<bool> > visitable (size_y, std::vector<bool> (size_x, 1) );
    for (int i = 0; i < size_y; ++i){
        for (int j = 0; j < size_x; ++j){
            char aux;
            std::cin >> aux;
            mapa[i][j] = aux;
            if ( aux == 'X') visitable[i][j] = 0;
        }
    }
    std::cin >> posicio_y >> posicio_x;
    bool resultat;
    resultat = busca(posicio_y, posicio_x, size_x, size_y, mapa, visitable);
    if (resultat) std::cout << "yes" << std::endl;
    else std::cout << "no" << std::endl;
}