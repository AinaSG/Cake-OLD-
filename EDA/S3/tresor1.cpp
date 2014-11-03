#include <iostream>
#include <vector>
#include <stack>
#include <struct>

struct pos{
    int x;
    int y;
};


void get_size(int & size_x, int & size_y){
    std::cin >> size_x >> size_y;
}

int main(){
    int size_x;
    int size_y;
    pos posicio;
    get_size(size_x, size_y);
    std::vector< std::vector<char> > mapa (size_y, std::vector<char> (size_x) );
    std::vector< std::vector<bool> > visitable (size_y, std::vector<bool> (size_x, 1) );
    for (int i = 0; i < size_y; ++i){
        for (int j = 0; j < size_x; ++j){
            char << aux;
            std::cin >> aux;
            mapa[i][j] = aux;
            if ( aux == 'X') visitable[i][j] = 0;
        }
    }
    std::cin >> posicio.y >> posicio.x;
}