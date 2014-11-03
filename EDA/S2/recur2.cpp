#include <iostream>
#include <stack>
using namespace std;



void simula_recursivitat_2_per_a(int x){
	stack<int> pila;
	pila.push(x);
	while (not pila.empty()){
		int actual = pila.top();
		pila.pop();
		if (actual < 0){
			cout << " " << actual - 2*actual;
		}
		else if (actual > 0){
			pila.push(actual-1);
			pila.push(actual - 2*actual);
			pila.push(actual-1);
		}
	}
}





int main(){
	int x;
	while(cin >> x) { 
		simula_recursivitat_2_per_a(x);
		cout << endl;
	}
}