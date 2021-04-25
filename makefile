OSFLAG 				:=
COMPILER :=
CXXFLAGS :=
ifeq ($(OS),Windows_NT)
	OSFLAG += -D WIN32
	ifeq ($(PROCESSOR_ARCHITECTURE),AMD64)
		OSFLAG += -D AMD64
	endif
	ifeq ($(PROCESSOR_ARCHITECTURE),x86)
		OSFLAG += -D IA32
	endif
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		OSFLAG += -D LINUX
		COMPILER += g++ -g
		CXXFLAGS += -c -std=c++11
	endif
	ifeq ($(UNAME_S),Darwin)
		OSFLAG += -D OSX
		COMPILER += clang++
		CXXFLAGS += -c -std=c++11
	endif
		UNAME_P := $(shell uname -p)
	ifeq ($(UNAME_P),x86_64)
		OSFLAG += -D AMD64
	endif
		ifneq ($(filter %86,$(UNAME_P)),)
	OSFLAG += -D IA32
		endif
	ifneq ($(filter arm%,$(UNAME_P)),)
		OSFLAG += -D ARM
	endif
endif



Project04: game.o entityBuilder.o itemBuilder.o encounter.o warrior.o monster.o priest.o rogue.o mage.o entity.o inventory.o item.o
	$(COMPILER) game.o entity.o encounter.o warrior.o monster.o mage.o rogue.o priest.o entityBuilder.o itemBuilder.o inventory.o item.o -o Project04


game.o: main.cpp entity.hpp warrior.hpp mage.hpp rogue.hpp priest.hpp JsonEntityBuilder.hpp json.hpp
	$(COMPILER) -c -std=c++11 main.cpp -o game.o


entityBuilder.o: JsonEntityBuilder.cpp JsonEntityBuilder.hpp json.hpp
	$(COMPILER) -c -std=c++11 JsonEntityBuilder.cpp -o entityBuilder.o

itemBuilder.o: JsonItemBuilder.cpp JsonItemBuilder.hpp json.hpp
	$(COMPILER) -c -std=c++11 JsonItemBuilder.cpp -o itemBuilder.o

encounter.o: encounter.cpp encounter.hpp entity.hpp
	$(COMPILER) -c -std=c++11 encounter.cpp -o encounter.o

inventory.o: inventory.cpp inventory.hpp item.hpp JsonItemBuilder.hpp
	$(COMPILER) -c -std=c++11 inventory.cpp -o inventory.o

item.o: item.cpp item.hpp JsonItemBuilder.hpp
	$(COMPILER) -c -std=c++11 item.cpp -o item.o

entity.o: entity.cpp entity.hpp JsonEntityBuilder.hpp JsonItemBuilder.hpp json.hpp
	$(COMPILER) -c -std=c++11 entity.cpp -o entity.o

warrior.o: warrior.cpp warrior.hpp entity.hpp JsonEntityBuilder.hpp json.hpp
	$(COMPILER) -c -std=c++11 warrior.cpp -o warrior.o

monster.o: monster.cpp monster.hpp entity.hpp JsonEntityBuilder.hpp json.hpp
	$(COMPILER) -c -std=c++11 monster.cpp -o monster.o

mage.o: mage.cpp mage.hpp entity.hpp JsonEntityBuilder.hpp json.hpp
	$(COMPILER) -c -std=c++11 mage.cpp -o mage.o

rogue.o: rogue.cpp rogue.hpp entity.hpp JsonEntityBuilder.hpp json.hpp
	$(COMPILER) -c -std=c++11 rogue.cpp -o rogue.o

priest.o: priest.cpp priest.hpp entity.hpp JsonEntityBuilder.hpp json.hpp
	$(COMPILER) -c -std=c++11 priest.cpp -o priest.o


# goblin.o: goblin.cpp goblin.hpp character.hpp inventory.hpp
# 	g++ -c goblin.cpp

clean:
	rm *.o Project04