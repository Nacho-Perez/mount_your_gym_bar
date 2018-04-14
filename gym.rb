# MONTAR PESAS EN UN GIMNASIO
#Definición de métodos
def mount_your_bar(weight)
    wg_less_bar = weight - @gym_bar              #Peso sin la barra (- 20kg)
    @wg_each_side = wg_less_bar / 2              #Peso a cada lado de la barra
    if @gym_weights.include? @wg_each_side       #Peso está en el array de pesos
        puts "-> Para cargar un peso de #{weight} kg debe poner #{@wg_each_side} kg a cada lado de la barra."
        puts "Por tanto, debe colocar una pesa de #{@wg_each_side} kg en cada lado"
    else        #Peso no está en el array de pesos -> hay que calcular las pesas
        while (@wg_each_side != 0) && (@wg_each_side > 1)  #No hay pesas de 1 kg
            how_many_gym_weights(@wg_each_side)            #Calcular pesas
        end
        write_weights                                      #Escribir pesas
    end
end
def how_many_gym_weights(weight)
    last_wg = 0
    @gym_weights.each do |wg|           #Comprueba la mayor pesa que puede coger para su peso
        if weight >= wg
            last_wg = wg
        else
            break
        end
    end
    if @hash_wg.has_key? last_wg        #hash de pesas ya tiene una pesa de esos kg
        @hash_wg[last_wg] += 1
    else                                #hash de pesas no tiene una pesa de esos kg
        @hash_wg[last_wg] = 1       
    end
    @wg_each_side = weight - last_wg    #peso_restante = peso_anterior - pesa_recién_guardada
end
def write_weights
    puts "Debe colocar las siguientes pesas a cada lado de la barra:" 
    @hash_wg.each do |what_wg, how_many_wg|  #Escribe cada par del hash de pesas
        if how_many_wg > 1
            puts "-> #{how_many_wg} pesas de #{what_wg} kg" 
        else
            puts "-> #{how_many_wg} pesa de #{what_wg} kg"    
        end
    end
end

#Inicialización de variables
@gym_weights = [2, 5, 10, 15, 20, 50]
@gym_bar = 20
@wg_each_side = 0
@hash_wg = {}

#Comienzo de la app MOUNT YOUR GYM BAR
puts "¿Qué peso (en kg) desea levantar para ponerse fuerte?"
my_weight = gets.chomp.to_i
if my_weight < 0                                #Nº negativos: <0
    puts "No se puede levantar peso que no pese. Introduce kg mayor que 0"
elsif my_weight < 1                             #Número 0
    puts "¿0 kg? Si no quieres levantar peso vete a tú casa"
elsif my_weight < 20                            #Rango: 1 - 20
    puts "Sólo la barra ya pesa 20 kg, así que no si quieres levantar más de 20 kg cambia de ejercicio"
elsif my_weight == 20                           #Peso = 20 kg
    puts "Para levantar 20 kg no necesitas colocar ninguna pesa en la barra"
elsif my_weight < 24                            #Rango: 21 - 23
    puts "La barra pesa 20 kg y la pesa mínima es de 2 kg, por lo que, debes levantar 24 kg como mínimo"
else                                            #Peso > 23 kg
    mount_your_bar(my_weight)
end