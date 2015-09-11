package haxegame.save
{
    import flash.*;
    import flash.net.*;
    import haxe.*;
    import haxegame.save._Record.*;

    public class Record extends Object
    {
        public var sharedObjectData:Object;
        public var sharedObject:SharedObject;
        public var saveData:SaveData;
        public static var KEY:String;
        public static var instance:Record;

        public function Record() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            sharedObject = SharedObject.getLocal("mydata");
            sharedObjectData = sharedObject.data;
            if (sharedObjectData.encryptedSaveData != null)
            {
                saveData = Unserializer.run(sharedObjectData.encryptedSaveData);
            }
            if (saveData == null)
            {
                saveData = new SaveData();
                save();
            }
            return;
        }// end function

        public function updateScore(param1:int, param2:int, param3:int, param4:int) : void
        {
            if (saveData.highScore < param1)
            {
                saveData.highScore = param1;
            }
            if (saveData.maxCombo < param2)
            {
                saveData.maxCombo = param2;
            }
            saveData.zombie = saveData.zombie + param3;
            saveData.human = saveData.human + param4;
            (saveData.playCount + 1);
            save();
            return;
        }// end function

        public function save() : void
        {
            var _loc_1:* = Serializer.run(saveData);
            sharedObjectData.encryptedSaveData = _loc_1;
            sharedObject.flush();
            return;
        }// end function

        public function remove() : void
        {
            sharedObject.clear();
            return;
        }// end function

        public function isJapaneseLanguage() : Boolean
        {
            return Type.enumEq(saveData.language, "ja");
        }// end function

        public function isBgmOn() : Boolean
        {
            return Type.enumEq(saveData.bgm, BGM.ON);
        }// end function

        public function getZombieSecretAchievement() : Boolean
        {
            if (saveData.zombie >= 2000)
            {
            }
            if (!saveData.zombieSecretAchievement)
            {
                saveData.zombieSecretAchievement = true;
                save();
                return true;
            }
            return false;
        }// end function

        public function getZombieAchievement() : Boolean
        {
            if (saveData.zombie >= 100)
            {
            }
            if (!saveData.zombieAchievement)
            {
                saveData.zombieAchievement = true;
                save();
                return true;
            }
            return false;
        }// end function

        public function getScoreSecretAchievement(param1:int) : Boolean
        {
            if (param1 >= 20000)
            {
            }
            if (!saveData.scoreSecretAchievement)
            {
                saveData.scoreSecretAchievement = true;
                if (saveData.highScore < param1)
                {
                    saveData.highScore = param1;
                }
                save();
                return true;
            }
            return false;
        }// end function

        public function getScoreAchievement(param1:int) : Boolean
        {
            if (param1 >= 5000)
            {
            }
            if (!saveData.scoreAchievement)
            {
                saveData.scoreAchievement = true;
                if (saveData.highScore < param1)
                {
                    saveData.highScore = param1;
                }
                save();
                return true;
            }
            return false;
        }// end function

        public function getPlayCountSecretAchievement() : Boolean
        {
            if (saveData.playCount >= 1000)
            {
            }
            if (!saveData.playCountSecretAchievement)
            {
                saveData.playCountSecretAchievement = true;
                save();
                return true;
            }
            return false;
        }// end function

        public function getPlayCountAchievement() : Boolean
        {
            if (saveData.playCount >= 10)
            {
            }
            if (!saveData.playCountAchievement)
            {
                saveData.playCountAchievement = true;
                save();
                return true;
            }
            return false;
        }// end function

        public function getHumanSecretAchievement() : Boolean
        {
            if (saveData.human >= 2000)
            {
            }
            if (!saveData.humanSecretAchievement)
            {
                saveData.humanSecretAchievement = true;
                save();
                return true;
            }
            return false;
        }// end function

        public function getHumanAchievement() : Boolean
        {
            if (saveData.human >= 100)
            {
            }
            if (!saveData.humanAchievement)
            {
                saveData.humanAchievement = true;
                save();
                return true;
            }
            return false;
        }// end function

        public function getComboSecretAchievement(param1:int) : Boolean
        {
            if (param1 >= 100)
            {
            }
            if (!saveData.comboSecretAchievement)
            {
                saveData.comboSecretAchievement = true;
                if (saveData.maxCombo < param1)
                {
                    saveData.maxCombo = param1;
                }
                save();
                return true;
            }
            return false;
        }// end function

        public function getComboAchievement(param1:int) : Boolean
        {
            if (param1 >= 10)
            {
            }
            if (!saveData.comboAchievement)
            {
                saveData.comboAchievement = true;
                if (saveData.maxCombo < param1)
                {
                    saveData.maxCombo = param1;
                }
                save();
                return true;
            }
            return false;
        }// end function

        public function changeLanguage(param1:String) : void
        {
            saveData.language = param1;
            save();
            return;
        }// end function

        public function changeBgm(param1:BGM) : void
        {
            saveData.bgm = param1;
            save();
            return;
        }// end function

        public static function getInstance() : Record
        {
            var _loc_1:* = null as Record;
            if (Record.instance == null)
            {
                _loc_1 = new Record();
                Record.instance = _loc_1;
                return _loc_1;
            }
            else
            {
                return Record.instance;
            }
        }// end function

    }
}
