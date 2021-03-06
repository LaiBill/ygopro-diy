--黑魔导导师
function c999999895.initial_effect(c)
	--超量召唤
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER),4,2,nil,nil,5)
	c:EnableReviveLimit()
	--移除所有素材
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(63504681,0))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_REPEAT)
	e1:SetCountLimit(1)
	e1:SetCondition(c999999895.reccon)
	e1:SetTarget(c999999895.rectg)
	e1:SetOperation(c999999895.recop)
	c:RegisterEffect(e1)
	--攻击力上升
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c999999895.atkval)
	c:RegisterEffect(e1)
	--攻击宣言
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetCountLimit(1)
	e3:SetCondition(c999999895.condition)
	e3:SetOperation(c999999895.operation)
	c:RegisterEffect(e3)
end
function c999999895.operation(e,tp,eg,ep,ev,re,r,rp)
    local clsc=e:GetHandler():GetOverlayCount()
	if clsc==2 then
	    local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_FIELD)
	    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	    e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	    e1:SetTargetRange(0,1)
	    e1:SetValue(c999999895.aclimit1)
	    e1:SetReset(RESET_PHASE+PHASE_END)
	    Duel.RegisterEffect(e1,tp)
	elseif clsc==3 then
	    local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_FIELD)
	    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	    e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	    e1:SetTargetRange(0,1)
	    e1:SetValue(c999999895.aclimit1)
	    e1:SetReset(RESET_PHASE+PHASE_END)
	    Duel.RegisterEffect(e1,tp)
        local e2=Effect.CreateEffect(e:GetHandler())
	    e2:SetType(EFFECT_TYPE_FIELD)
	    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	    e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	    e2:SetTargetRange(0,1)
	    e2:SetValue(c999999895.aclimit2)
	    e2:SetReset(RESET_PHASE+PHASE_END)
	    Duel.RegisterEffect(e2,tp)
	elseif clsc==4 then
	    local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_FIELD)
	    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	    e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	    e1:SetTargetRange(0,1)
	    e1:SetValue(c999999895.aclimit1)
	    e1:SetReset(RESET_PHASE+PHASE_END)
	    Duel.RegisterEffect(e1,tp)
        local e2=Effect.CreateEffect(e:GetHandler())
	    e2:SetType(EFFECT_TYPE_FIELD)
	    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	    e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	    e2:SetTargetRange(0,1)
	    e2:SetValue(c999999895.aclimit2)
	    e2:SetReset(RESET_PHASE+PHASE_END)
	    Duel.RegisterEffect(e2,tp)
		local e3=Effect.CreateEffect(e:GetHandler())
	    e3:SetType(EFFECT_TYPE_SINGLE)
	    e3:SetCode(EFFECT_ATTACK_ALL)
	    e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_BATTLE)
	    e3:SetValue(1)
	    e:GetHandler():RegisterEffect(e3)
	elseif clsc>=5 then
	     local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_FIELD)
	    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	    e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	    e1:SetTargetRange(0,1)
	    e1:SetValue(c999999895.aclimit1)
	    e1:SetReset(RESET_PHASE+PHASE_END)
	    Duel.RegisterEffect(e1,tp)
        local e2=Effect.CreateEffect(e:GetHandler())
	    e2:SetType(EFFECT_TYPE_FIELD)
	    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	    e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	    e2:SetTargetRange(0,1)
	    e2:SetValue(c999999895.aclimit2)
	    e2:SetReset(RESET_PHASE+PHASE_END)
	    Duel.RegisterEffect(e2,tp)
		local e3=Effect.CreateEffect(e:GetHandler())
	    e3:SetType(EFFECT_TYPE_SINGLE)
	    e3:SetCode(EFFECT_ATTACK_ALL)
	    e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_BATTLE)
	    e3:SetValue(1)
	    e:GetHandler():RegisterEffect(e3)
		local e4=Effect.CreateEffect(e:GetHandler())
    	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    	e4:SetCode(EVENT_PRE_BATTLE_DAMAGE)
    	e4:SetCondition(c999999895.damcon)
    	e4:SetOperation(c999999895.damop)
		e4:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_BATTLE)
    	e:GetHandler():RegisterEffect(e4)
	else return false end
end
function c999999895.damcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c999999895.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev*2)
end
function c999999895.aclimit1(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c999999895.aclimit1(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER)
end
function c999999895.atkval(e,c)
	return Duel.GetMatchingGroupCount(Card.IsType,c:GetControler(),LOCATION_GRAVE,0,nil,TYPE_SPELL)*200
end
function c999999895.reccon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c999999895.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local sl=e:GetHandler():GetOverlayCount()
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(sl*500)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,sl*500)
end
function c999999895.recop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
	local sl=e:GetHandler():GetOverlayCount()
	if c:GetOverlayCount()>0 then
		c:RemoveOverlayCard(tp,sl,sl,REASON_EFFECT)
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	    Duel.Recover(p,d,REASON_EFFECT)
	end
end
function c999999895.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayCount()>=1
end
