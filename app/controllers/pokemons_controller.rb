class PokemonsController < ApplicationController
	def capture
		id = params["id"]
		trainer = current_trainer
		pokemon = Pokemon.find(id)
		pokemon.trainer_id = trainer.id
		pokemon.save
		redirect_to root_path
	end

	def damage
		id = params["id"]
		pokemon = Pokemon.find(id)
		pokemon.health -= 10
		pokemon.save
		if pokemon.health <= 0
			pokemon.destroy
		end
		redirect_to trainer_path(pokemon.trainer_id)
	end

	def new
		@pokemon = Pokemon.new
	end

	def create
		@pokemon = Pokemon.new(pokemon_params)
		@pokemon.trainer_id = current_trainer.id
		@pokemon.health = 100
		@pokemon.level = 1
		if @pokemon.save
			redirect_to trainer_path(@pokemon.trainer_id)
		else
			render "new"
		end
	end
	
	def pokemon_params
		params.require(:pokemon).permit(:name)
	end
end
