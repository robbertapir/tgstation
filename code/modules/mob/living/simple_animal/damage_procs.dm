/**
 * Adjusts the health of a simple mob by a set amount and wakes AI if its idle to react
 *
 * Arguments:
 * * amount The amount that will be used to adjust the mob's health
 * * updating_health If the mob's health should be immediately updated to the new value
 * * forced If we should force update the adjustment of the mob's health no matter the restrictions, like GODMODE
 */
/mob/living/simple_animal/proc/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	. = FALSE
	if(forced || !(status_flags & GODMODE))
		bruteloss = round(clamp(bruteloss + amount, 0, maxHealth * 2), DAMAGE_PRECISION)
		if(updating_health)
			updatehealth()
		. = amount
	if(ckey || stat)
		return
	if(AIStatus == AI_IDLE)
		toggle_ai(AI_ON)

/mob/living/simple_animal/adjustBruteLoss(amount, updating_health = TRUE, forced = FALSE, required_status)
	if(forced)
		. = adjustHealth(amount * CONFIG_GET(number/damage_multiplier), updating_health, forced)
	else if(damage_coeff[BRUTE])
		. = adjustHealth(amount * damage_coeff[BRUTE] * CONFIG_GET(number/damage_multiplier), updating_health, forced)

/mob/living/simple_animal/adjustFireLoss(amount, updating_health = TRUE, forced = FALSE, required_status)
	if(forced)
		. = adjustHealth(amount * CONFIG_GET(number/damage_multiplier), updating_health, forced)
	else if(damage_coeff[BURN])
		. = adjustHealth(amount * damage_coeff[BURN] * CONFIG_GET(number/damage_multiplier), updating_health, forced)

/mob/living/simple_animal/adjustOxyLoss(amount, updating_health = TRUE, forced = FALSE)
	if(forced)
		. = adjustHealth(amount * CONFIG_GET(number/damage_multiplier), updating_health, forced)
	else if(damage_coeff[OXY])
		. = adjustHealth(amount * damage_coeff[OXY] * CONFIG_GET(number/damage_multiplier), updating_health, forced)

/mob/living/simple_animal/adjustToxLoss(amount, updating_health = TRUE, forced = FALSE)
	if(forced)
		. = adjustHealth(amount * CONFIG_GET(number/damage_multiplier), updating_health, forced)
	else if(damage_coeff[TOX])
		. = adjustHealth(amount * damage_coeff[TOX] * CONFIG_GET(number/damage_multiplier), updating_health, forced)

/mob/living/simple_animal/adjustCloneLoss(amount, updating_health = TRUE, forced = FALSE)
	if(forced)
		. = adjustHealth(amount * CONFIG_GET(number/damage_multiplier), updating_health, forced)
	else if(damage_coeff[CLONE])
		. = adjustHealth(amount * damage_coeff[CLONE] * CONFIG_GET(number/damage_multiplier), updating_health, forced)

/mob/living/simple_animal/adjustStaminaLoss(amount, updating_stamina = TRUE, forced = FALSE)
	if(forced)
		staminaloss = max(0, min(max_staminaloss, staminaloss + amount))
	else
		staminaloss = max(0, min(max_staminaloss, staminaloss + (amount * damage_coeff[STAMINA])))
	if(updating_stamina)
		update_stamina()
