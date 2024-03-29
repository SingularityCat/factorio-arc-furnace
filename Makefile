VER := ${shell python3 -c 'import json; print(json.load(open("TheArcFurnaceImp/info.json"))["version"])'}

.PHONY: all
all:
	@rm TheArcFurnaceImp_${VER}.zip 2> /dev/null | :
	zip -r TheArcFurnaceImp_${VER}.zip TheArcFurnaceImp

.PHONY: install
install: all
	cp TheArcFurnaceImp_${VER}.zip  ~/.factorio/mods

.PHONY: clean
clean:
	rm TheArcFurnaceImp_*.zip
