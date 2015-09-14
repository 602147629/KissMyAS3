package quest
{
    import character.*;
    import flash.display.*;
    import item.*;
    import layer.*;
    import player.*;
    import popup.*;
    import resource.*;
    import topbar.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class QuestResultMain extends Object
    {
        private var _phase:int;
        private var _mc:MovieClip;
        private var _isoMain:InStayOut;
        private var _bResultClose:Boolean;
        private var _bmBustUp:Bitmap;
        private var _bEnd:Boolean;
        private var _questResult:QuestResult;
        private var _questReward:QuestResultReward;
        private var _questChronology:QuestChronology;
        private static const PHASE_OPEN:int = 1;
        private static const PHASE_RESULT:int = 10;
        private static const PHASE_REWARD:int = 20;
        private static const PHASE_CHRONOLOGY:int = 30;
        private static const PHASE_CLOSE:int = 40;
        private static const PHASE_END:int = 999;

        public function QuestResultMain(param1:MovieClip, param2:LayerQuest)
        {
            this._mc = param1;
            var _loc_3:* = UserDataManager.getInstance().userData.emperorId;
            var _loc_4:* = PlayerManager.getInstance().getPlayerInformation(_loc_3);
            this._bmBustUp = ResourceManager.getInstance().createBitmap(ResourcePath.PLAYER_BUSTUP_PATH + _loc_4.bustUpFileName);
            this._bmBustUp.smoothing = true;
            this._bmBustUp.x = this._bmBustUp.x - this._bmBustUp.width / 2;
            this._bmBustUp.y = this._bmBustUp.y - this._bmBustUp.height;
            if (_loc_4.id == PlayerId.ID_Jean_CL02_SR)
            {
                this._bmBustUp.y = this._bmBustUp.y + 150;
            }
            this._mc.charaNull.addChild(this._bmBustUp);
            this._isoMain = new InStayOut(this._mc);
            this._questResult = new QuestResult(this._mc.resultMc, param2);
            this._questReward = new QuestResultReward(this._mc.resultRewardMc, param2);
            this._questChronology = new QuestChronology(this._mc.chronologicalTableMc);
            this._bResultClose = false;
            this.setPhase(PHASE_OPEN);
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function release() : void
        {
            if (this._bmBustUp && this._bmBustUp.parent != null)
            {
                this._bmBustUp.parent.removeChild(this._bmBustUp);
            }
            this._bmBustUp = null;
            if (this._questResult)
            {
                this._questResult.release();
            }
            this._questResult = null;
            if (this._questReward)
            {
                this._questReward.release();
            }
            this._questReward = null;
            if (this._questChronology)
            {
                this._questChronology.release();
            }
            this._questChronology = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mc)
            {
                if (this._mc.parent)
                {
                    this._mc.parent.removeChild(this._mc);
                }
            }
            this._mc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case PHASE_RESULT:
                {
                    this.controlResult(param1);
                    break;
                }
                case PHASE_REWARD:
                {
                    this.controlReward(param1);
                    break;
                }
                case PHASE_CHRONOLOGY:
                {
                    this.controlChronology(param1);
                    break;
                }
                case PHASE_CLOSE:
                {
                    this.controlClose();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (this._phase != param1)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case PHASE_RESULT:
                    {
                        this.phaseResult();
                        break;
                    }
                    case PHASE_REWARD:
                    {
                        this.phaseReward();
                        break;
                    }
                    case PHASE_CHRONOLOGY:
                    {
                        this.phaseChronology();
                        break;
                    }
                    case PHASE_CLOSE:
                    {
                        this.phaseClose();
                        break;
                    }
                    case PHASE_END:
                    {
                        this.phaseEnd();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function phaseOpen() : void
        {
            this._isoMain.setIn();
            return;
        }// end function

        private function controlOpen() : void
        {
            if (this._isoMain && this._isoMain.bOpened)
            {
                this.setPhase(PHASE_RESULT);
            }
            return;
        }// end function

        private function phaseResult() : void
        {
            this._questResult.setIn();
            return;
        }// end function

        private function controlResult(param1:Number) : void
        {
            var _loc_2:* = null;
            if (this._questResult.bClose)
            {
                _loc_2 = Main.GetProcess().topBar;
                if (_loc_2)
                {
                    _loc_2.update();
                }
                this.setPhase(PHASE_REWARD);
            }
            if (this._questResult != null)
            {
                this._questResult.control(param1);
            }
            return;
        }// end function

        private function phaseReward() : void
        {
            this._questReward.setIn();
            return;
        }// end function

        private function controlReward(param1:Number) : void
        {
            var t:* = param1;
            if (this._questReward.bClose && this._bResultClose == false)
            {
                this._bResultClose = true;
                if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_TUTORIAL_QUEST_END))
                {
                    TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_TUTORIAL_QUEST_END, function () : void
            {
                setPhase(PHASE_CLOSE);
                return;
            }// end function
            );
                }
                else
                {
                    this.setPhase(PHASE_CHRONOLOGY);
                }
            }
            if (this._questReward != null)
            {
                this._questReward.control(t);
            }
            return;
        }// end function

        private function phaseChronology() : void
        {
            this._questChronology.setIn();
            return;
        }// end function

        private function controlChronology(param1:Number) : void
        {
            if (this._questChronology.bClose && CommonPopup.isUse() == false)
            {
                this.setPhase(PHASE_CLOSE);
            }
            if (this._questChronology != null)
            {
                this._questChronology.control(param1);
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            this._isoMain.setOut();
            return;
        }// end function

        private function controlClose() : void
        {
            if (this._isoMain && this._isoMain.bEnd)
            {
                this.setPhase(PHASE_END);
            }
            return;
        }// end function

        private function phaseEnd() : void
        {
            this._bEnd = true;
            return;
        }// end function

        public static function getResource() : String
        {
            return ResourcePath.RESULT_PATH + "UI_Result.swf";
        }// end function

        public static function getRemunerationResource(param1:QuestRemunerationData) : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = false;
            if (param1.categoryId == CommonConstant.ITEM_KIND_WARRIOR)
            {
                _loc_3 = PlayerManager.getInstance().getPlayerInformation(param1.itemId);
                if (_loc_3 != null)
                {
                    ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_3.swf);
                    ResourceManager.getInstance().loadResource(ResourcePath.CARD_BIG_PATH + CharacterConstant.ID_CARD + _loc_3.cardFileName);
                }
                _loc_2 = true;
            }
            else
            {
                _loc_4 = ItemManager.getInstance().getItemPng(param1.categoryId, param1.itemId);
                ResourceManager.getInstance().loadResource(_loc_4);
            }
            return _loc_2;
        }// end function

    }
}
