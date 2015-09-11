class pjam.scene.ItemUse
{
    var root, pdata, scene, num;
    function ItemUse(root, pdata)
    {
        this.root = root;
        this.pdata = pdata;
        scene = root.stageMC.itemMC;
    } // End of the function
    function start()
    {
        var sc = this;
        scene.backBtn.onPress = function ()
        {
            sc.end();
        };
        var _loc3 = pdata.getItemList();
        for (var _loc2 = 0; _loc2 < 3; ++_loc2)
        {
            scene["itemTxt" + _loc2].text = pjam.Charactor.getItemName(root, _loc3[_loc2]);
            scene["btn" + _loc2].num = _loc3[_loc2];
            scene["btn" + _loc2].onPress = function ()
            {
                sc.check(num);
            };
        } // end of for
    } // End of the function
    function check(num)
    {
        if (num == -1)
        {
            return;
        } // end if
        var sc = this;
        scene.nextFrame();
        var _loc3 = pjam.Charactor.getCharData(root, pdata.createRegistData());
        scene.hpBfrTxt.text = _loc3.hp;
        scene.attackBfrTxt.text = _loc3.attack;
        scene.magicBfrTxt.text = _loc3.magic;
        scene.defenseBfrTxt.text = _loc3.defense;
        scene.speedBfrTxt.text = _loc3.speed;
        scene.luckBfrTxt.text = _loc3.luck;
        var _loc2 = pjam.Charactor.getCharData(root, pdata.createUseItemData(num));
        scene.hpAfrTxt.text = _loc2.hp;
        scene.attackAfrTxt.text = _loc2.attack;
        scene.magicAfrTxt.text = _loc2.magic;
        scene.defenseAfrTxt.text = _loc2.defense;
        scene.speedAfrTxt.text = _loc2.speed;
        scene.luckAfrTxt.text = _loc2.luck;
        scene.charNameTxt.text = _loc2.charName;
        scene.charMC.attachMovie(_loc2.id, _loc2.id, 1);
        scene.backBtn.onPress = function ()
        {
            sc.scene.prevFrame();
            sc.start();
        };
        scene.okBtn.onPress = function ()
        {
            sc.pdata.setCharNum(num);
            sc.end();
        };
    } // End of the function
} // End of Class
