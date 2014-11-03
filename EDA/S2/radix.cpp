#include <iostream>
#include <vector>
#include <queue>
using namespace std;

void radix_sort_per_a(queue<string> & Q){
	vector< queue<string> > abc('z' - 'a' + 1);
	int longpal;
    if (Q.empty()) longpal = -1;
    else longpal = Q.front().size();
    
    for (int i = longpal - 1; i >= 0; --i) {
        while (not Q.empty()) {
            string pal = Q.front();
            Q.pop();
            abc[pal[i] - 'a'].push(pal);
        }
        for (int y = 0; y < int(abc.size()); ++y) {
            while (not abc[y].empty()) {
                Q.push(abc[y].front());
                abc[y].pop();
            }
        }
    }
}


int main (){
	queue<string> Q;
	string s;
	while(cin >> s) Q.push(s);
	radix_sort_per_a(Q);
	bool first = true;
	while (not Q.empty()){
		if (not first) cout << " ";
		else first = false;
		cout << Q.front();
		Q.pop();	
	}
	cout << endl;
}