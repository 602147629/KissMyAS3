package process
{
    import area.*;
    import asset.*;
    import battle.*;
    import button.*;
    import enemy.*;
    import facility.*;
    import formation.*;
    import item.*;
    import makeEquip.*;
    import message.*;
    import payment.*;
    import player.*;
    import quest.*;
    import resource.*;
    import script.*;
    import skill.*;
    import sound.*;
    import trainingRoom.*;
    import user.*;

    public class ProcessInitialize extends ProcessBase
    {
        private var _phase:int;
        private var _aCommonSoundId:Array;
        private static const _PHASE_LOAD_INIT_RESOURCE:int = 1;
        private static const _PHASE_LOAD_AREA_INFORMATION:int = 10;
        private static const _PHASE_LOAD_PLAYER_INFORMATION:int = 20;
        private static const _PHASE_LOAD_SKILL_INFORMATION:int = 30;
        private static const _PHASE_LOAD_ENEMY_INFORMATION:int = 40;
        private static const _PHASE_LOAD_USER_INFORMATION:int = 50;
        private static const _PHASE_LOAD_ITEM_INFORMATION:int = 60;
        private static const _PHASE_LOAD_ASSET_INFORMATION:int = 70;
        private static const _PHASE_LOAD_BATTLE_INFORMATION:int = 80;
        private static const _PHASE_LOAD_PAYMENT_INFORMATION:int = 90;
        private static const _PHASE_LOAD_FACILITY_LIST_INFORMATION:int = 100;
        private static const _PHASE_LOAD_KUMITE_LIST_INFORMATION:int = 110;
        private static const _PHASE_LOAD_RECIPE_INFORMATION:int = 120;
        private static const _PHASE_LOAD_MESSAGE_INFORMATION:int = 130;
        private static const _PHASE_LOAD_SOUND_LIST:int = 140;
        private static const _PHASE_LOAD_QUEST_RESULT_MESSAGE:int = 150;
        private static const _PHASE_LOAD_SCRIPT_FLAG:int = 160;
        private static const _PHASE_LOAD_SOUND_DATA:int = 170;
        private static const _PHASE_DEVELOP:int = 1000;

        public function ProcessInitialize()
        {
            this._aCommonSoundId = [SoundId.SE_DECIDE, ButtonBase.SE_DECIDE_ID, ButtonBase.SE_CANCEL_ID, ButtonBase.SE_CURSOR_ID, ButtonBase.SE_SELECT_ID];
            return;
        }// end function

        override public function init() : void
        {
            this.setPhase(_PHASE_LOAD_INIT_RESOURCE);
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case _PHASE_LOAD_INIT_RESOURCE:
                {
                    if (ResourceManager.getInstance().isLoaded())
                    {
                        this.setPhase(_PHASE_LOAD_MESSAGE_INFORMATION);
                    }
                    break;
                }
                case _PHASE_LOAD_MESSAGE_INFORMATION:
                {
                    if (MessageManager.getInstance().isLoaded())
                    {
                        this.setPhase(_PHASE_LOAD_USER_INFORMATION);
                    }
                    break;
                }
                case _PHASE_LOAD_USER_INFORMATION:
                {
                    if (UserDataManager.getInstance().isLoaded())
                    {
                        this.setPhase(_PHASE_LOAD_SKILL_INFORMATION);
                    }
                    break;
                }
                case _PHASE_LOAD_SKILL_INFORMATION:
                {
                    if (SkillManager.getInstance().isLoaded())
                    {
                        this.setPhase(_PHASE_LOAD_ENEMY_INFORMATION);
                    }
                    break;
                }
                case _PHASE_LOAD_ENEMY_INFORMATION:
                {
                    if (EnemyManager.getInstance().isLoaded())
                    {
                        this.setPhase(_PHASE_LOAD_AREA_INFORMATION);
                    }
                }
                case _PHASE_LOAD_AREA_INFORMATION:
                {
                    if (AreaManager.getInstance().isLoaded())
                    {
                        this.setPhase(_PHASE_LOAD_ITEM_INFORMATION);
                    }
                    break;
                }
                case _PHASE_LOAD_ITEM_INFORMATION:
                {
                    if (ItemManager.getInstance().isLoaded())
                    {
                        this.setPhase(_PHASE_LOAD_ASSET_INFORMATION);
                    }
                    break;
                }
                case _PHASE_LOAD_ASSET_INFORMATION:
                {
                    if (AssetListManager.getInstance().isLoaded())
                    {
                        this.setPhase(_PHASE_LOAD_BATTLE_INFORMATION);
                    }
                    break;
                }
                case _PHASE_LOAD_BATTLE_INFORMATION:
                {
                    if (BattleInformationManager.getInstance().isLoaded())
                    {
                        this.setPhase(_PHASE_LOAD_PAYMENT_INFORMATION);
                    }
                    break;
                }
                case _PHASE_LOAD_PAYMENT_INFORMATION:
                {
                    if (PaymentManager.getInstance().isLoaded())
                    {
                        this.setPhase(_PHASE_LOAD_FACILITY_LIST_INFORMATION);
                    }
                    break;
                }
                case _PHASE_LOAD_FACILITY_LIST_INFORMATION:
                {
                    if (FacilityListManager.getInstance().isLoaded())
                    {
                        this.setPhase(_PHASE_LOAD_KUMITE_LIST_INFORMATION);
                    }
                    break;
                }
                case _PHASE_LOAD_KUMITE_LIST_INFORMATION:
                {
                    if (KumiteListManager.getInstance().isLoaded())
                    {
                        this.setPhase(_PHASE_LOAD_RECIPE_INFORMATION);
                    }
                    break;
                }
                case _PHASE_LOAD_RECIPE_INFORMATION:
                {
                    if (RecipeParameterManager.getInstance().isLoaded())
                    {
                        this.setPhase(_PHASE_LOAD_SOUND_LIST);
                    }
                    break;
                }
                case _PHASE_LOAD_SOUND_LIST:
                {
                    if (SoundManager.getInstance().isListLoaded())
                    {
                        this.setPhase(_PHASE_LOAD_QUEST_RESULT_MESSAGE);
                    }
                    break;
                }
                case _PHASE_LOAD_QUEST_RESULT_MESSAGE:
                {
                    if (QuestManager.getInstance().isListLoaded())
                    {
                        this.setPhase(_PHASE_LOAD_SCRIPT_FLAG);
                    }
                    break;
                }
                case _PHASE_LOAD_SCRIPT_FLAG:
                {
                    if (ScriptManager.getInstance().isListLoaded())
                    {
                        this.setPhase(_PHASE_LOAD_SOUND_DATA);
                    }
                    break;
                }
                case _PHASE_LOAD_SOUND_DATA:
                {
                    if (SoundManager.getInstance().isLoaded())
                    {
                        this.setPhase(_PHASE_LOAD_PLAYER_INFORMATION);
                    }
                    break;
                }
                case _PHASE_LOAD_PLAYER_INFORMATION:
                {
                    if (PlayerManager.getInstance().isLoaded())
                    {
                        Main.GetProcess().SetProcessId(ProcessMain.PROCESS_LOGIN);
                    }
                    break;
                }
                case _PHASE_DEVELOP:
                {
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
            var _loc_2:* = 0;
            var _loc_3:* = null;
            this._phase = param1;
            switch(this._phase)
            {
                case _PHASE_LOAD_INIT_RESOURCE:
                {
                    ResourceManager.getInstance().loadFont();
                    break;
                }
                case _PHASE_LOAD_MESSAGE_INFORMATION:
                {
                    MessageManager.getInstance().loadData();
                    break;
                }
                case _PHASE_LOAD_AREA_INFORMATION:
                {
                    AreaManager.getInstance().loadData();
                    break;
                }
                case _PHASE_LOAD_PLAYER_INFORMATION:
                {
                    PlayerManager.getInstance().loadData();
                    break;
                }
                case _PHASE_LOAD_SKILL_INFORMATION:
                {
                    SkillManager.getInstance().loadData();
                    FormationManager.getInstance().loadData();
                    break;
                }
                case _PHASE_LOAD_ENEMY_INFORMATION:
                {
                    EnemyManager.getInstance().loadData();
                    break;
                }
                case _PHASE_LOAD_USER_INFORMATION:
                {
                    UserDataManager.getInstance().loadData();
                    break;
                }
                case _PHASE_LOAD_ITEM_INFORMATION:
                {
                    ItemManager.getInstance().loadData();
                    break;
                }
                case _PHASE_LOAD_ASSET_INFORMATION:
                {
                    AssetListManager.getInstance().loadData();
                    break;
                }
                case _PHASE_LOAD_BATTLE_INFORMATION:
                {
                    BattleInformationManager.getInstance().loadData();
                    break;
                }
                case _PHASE_LOAD_PAYMENT_INFORMATION:
                {
                    PaymentManager.getInstance().loadData();
                    break;
                }
                case _PHASE_LOAD_FACILITY_LIST_INFORMATION:
                {
                    FacilityListManager.getInstance().loadData();
                    break;
                }
                case _PHASE_LOAD_KUMITE_LIST_INFORMATION:
                {
                    KumiteListManager.getInstance().loadData();
                    break;
                }
                case _PHASE_LOAD_RECIPE_INFORMATION:
                {
                    RecipeParameterManager.getInstance().loadData();
                    break;
                }
                case _PHASE_LOAD_SOUND_LIST:
                {
                    SoundManager.getInstance().loadListData();
                    break;
                }
                case _PHASE_LOAD_QUEST_RESULT_MESSAGE:
                {
                    QuestManager.getInstance().loadListData();
                    break;
                }
                case _PHASE_LOAD_SCRIPT_FLAG:
                {
                    ScriptManager.getInstance().loadListData();
                    break;
                }
                case _PHASE_LOAD_SOUND_DATA:
                {
                    for each (_loc_2 in this._aCommonSoundId)
                    {
                        
                        _loc_3 = SoundManager.getInstance().loadSound(_loc_2);
                        _loc_3.bRemoveLock = true;
                    }
                    break;
                }
                case _PHASE_DEVELOP:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
