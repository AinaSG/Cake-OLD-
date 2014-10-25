require "std.table"

function love.load() --Callback al inici de la execució.
	num_of_clusters = 2 --Numero de clusters
	num_of_points = 0 --Numero de punts
	id_counter = 0 -- Numerar els punts per ID
	Puntets = {}
	Centroides = {}
	coord = love.filesystem.newFile( "coordenades.txt" )
	coord:open("w") --Obrir en mode escriptura per borrar contngut anterior
	coord:close()
	calculating = false --- Variable per marcar si no es poden introduir punts al programa perquè es troba calculant clusters
	-------IMATGES PER A LA INTERFICIE GRAFICA------------
	play = love.graphics.newImage( "play.png" )
	pause = love.graphics.newImage( "pause.png")
	two = love.graphics.newImage("2.png")
	tree = love.graphics.newImage("3.png")
	four = love.graphics.newImage("4.png")

end

function love.update(dt) --calcul entre frames, si es calcula, aquí es fa la crida 
	if (calculating) then
		kmeans()
		--calculating = false
	end
end

function love.draw() --Love. draw. Dibuixa els botons i els punts a cada frame
	if (calculating)then
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(pause, 0, 0)
	end

	if (not calculating) then
		draw_numbers()
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(play, 0, 0)
		for n, Puntet in pairs(Puntets) do --Dibuixar cada puntet en iteració per la taula
			love.graphics.setColor(Puntet.r, Puntet.g, Puntet.b, 255)
			love.graphics.rectangle("line", (Puntet.x-5), (Puntet.y-5), 10, 10 )
			love.graphics.print(Puntet.id , (Puntet.x+5), (Puntet.y-5))
		end
	end
	
end

function love.mousepressed(x, y, button) --Callback de click del ratolí detecta si es tracta d'un botó o de si s ha de posar un nou punt
	if (not calculating) then
		if ((x<=100) and (y<=50)) then 
			calculating = true
			reset_Puntets()
		elseif ((y<=50) and (x < 180)) then num_of_clusters = 2
		elseif ((y<=50) and (x < 245)) then num_of_clusters = 3
		elseif ((y<=50) and (x < 295)) then num_of_clusters = 4
		else 
			if button == 'l' then afegirPuntet(x,y) end
		end
	else 
		if ((x<=100) and (y<=50)) then
			calculating = false
		end
	end
end

function afegirPuntet(px, py) --Afeigeix puntet a la coordenada px,py assigna color random, assigna id corresp.
	local Puntet = {}
	coord:open("a")
	coord:write(id_counter .. " : " .. px .. " " .. py .. "\r\n")
	Puntet.id = id_counter;
	Puntet.r = math.random(0, 254)
	Puntet.g = math.random(0, 254)
	Puntet.b = math.random(0, 254)
	Puntet.x = px
	Puntet.y = py
	table.insert (Puntets, Puntet)
	id_counter = id_counter + 1
	num_of_points = num_of_points + 1
	coord:close()
end

function reset_Puntets() --Fa reset de la taula de puntets i del document on es desen 
	num_of_points = 0
	Puntets = nil
	Puntets = {}
	id_counter = 0
	coord:open("w") --Obrir en mode escriptura per borrar contngut anterior
	coord:close()
end

function draw_numbers() --Dibuixa els "numeretes" de dal
	if (num_of_clusters == 2) then --Dos clusters
		love.graphics.setColor(255, 0, 0)
		love.graphics.draw(two, 115, 0)
		love.graphics.setColor(0, 255, 0)
		love.graphics.draw(tree, 180, 0)
		love.graphics.draw(four, 245, 0)

	elseif (num_of_clusters == 3) then --Tres clusters
		love.graphics.setColor(255, 0, 0)
		love.graphics.draw(tree, 180, 0)
		love.graphics.setColor(0, 255, 0)
		love.graphics.draw(two, 115, 0)
		love.graphics.draw(four, 245, 0)

	else --Cuatre clusters
		love.graphics.setColor(255, 0, 0)
		love.graphics.draw(four, 245, 0)
		love.graphics.setColor(0, 255, 0)
		love.graphics.draw(two, 115, 0)
		love.graphics.draw(tree, 180, 0)
	end
end


 function kmeans() --Calcula el resultat
 	initialize()
 	kMeansCluster()
 end

 function initialize() --Inicialitzar el calcul
 	Centroides = nil
	Centroides = {}
 	
 end

 function kMeansCluster() --Cos del calcul

 end


 --[[
		TO DO
-Els dos (tres, cuatre...) poden ser aleatoris
-NOTA: Amb 8 o 9 iteracions hauria de ser suficient
-Test bla bal

 ]]