package enemy
{
    import flash.display.*;
    import sound.*;

    public class EnemyBossNemea extends EnemyDisplay
    {
        private var _enemyId:int;

        public function EnemyBossNemea(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            super(param1, param2, param3);
            this._enemyId = param2;
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            return;
        }// end function

        override protected function controlAnim(param1:Number) : void
        {
            super.controlAnim(param1);
            this.playSeMotion();
            return;
        }// end function

        private function playSeMotion() : void
        {
            if (_bLabelAnimDetailChange == false)
            {
                return;
            }
            switch(this._enemyId)
            {
                case EnemyId.id_mons_Nemea_First_IS:
                {
                    if (_labelAnimDetail == "se1001")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_NEMEA1_ATTACK_START);
                    }
                    if (_labelAnimDetail == "se1002")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_NEMEA1_ATTACK_GROW);
                    }
                    if (_labelAnimDetail == "se1003")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_NEMEA1_ATTACK_CROW);
                    }
                    if (_labelAnimDetail == "se1004")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_NEMEA1_ATTACK_SWORD);
                    }
                    if (_labelAnimDetail == "se2001")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_NEMEA1_MAGIC_START);
                    }
                    if (_labelAnimDetail == "se2002")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_NEMEA1_MAGIC_SHOT);
                    }
                    if (_labelAnimDetail == "se3001")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_NEMEA1_CHANGE_IN);
                    }
                    break;
                }
                case EnemyId.id_mons_Nemea_Second_IS:
                {
                    if (_labelAnimDetail == "se1001")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_NEMEA2_ATTACK_START);
                    }
                    if (_labelAnimDetail == "se1002")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_NEMEA2_ATTACK_CROW);
                    }
                    if (_labelAnimDetail == "se1005")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_NEMEA2_ATTACK_CROW);
                    }
                    if (_labelAnimDetail == "se1003")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_NEMEA2_ATTACK_KAMAE);
                    }
                    if (_labelAnimDetail == "se1004")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_NEMEA2_ATTACK_SWORD);
                    }
                    if (_labelAnimDetail == "se2001")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_NEMEA2_MAGIC_START);
                    }
                    if (_labelAnimDetail == "se2002")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_NEMEA2_MAGIC_SHOT);
                    }
                    if (_labelAnimDetail == "se4001")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_NEMEA2_CHANGE_OUT_START);
                    }
                    if (_labelAnimDetail == "se4002")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_NEMEA2_CHANGE_OUT_FOREHEAD);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public static function getResource() : Array
        {
            var _loc_1:* = [];
            return _loc_1;
        }// end function

        public static function getSoundResource() : Array
        {
            return [SoundId.SE_REV_NEMEA1_ATTACK_START, SoundId.SE_REV_NEMEA1_ATTACK_GROW, SoundId.SE_REV_NEMEA1_ATTACK_CROW, SoundId.SE_REV_NEMEA1_ATTACK_SWORD, SoundId.SE_REV_NEMEA1_MAGIC_START, SoundId.SE_REV_NEMEA1_MAGIC_SHOT, SoundId.SE_REV_NEMEA1_CHANGE_IN, SoundId.SE_REV_NEMEA2_ATTACK_START, SoundId.SE_REV_NEMEA2_ATTACK_CROW, SoundId.SE_REV_NEMEA2_ATTACK_CROW, SoundId.SE_REV_NEMEA2_ATTACK_KAMAE, SoundId.SE_REV_NEMEA2_ATTACK_SWORD, SoundId.SE_REV_NEMEA2_MAGIC_START, SoundId.SE_REV_NEMEA2_MAGIC_SHOT, SoundId.SE_REV_NEMEA2_CHANGE_OUT_START, SoundId.SE_REV_NEMEA2_CHANGE_OUT_FOREHEAD];
        }// end function

    }
}
