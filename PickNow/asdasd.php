<?php
	$days = array('Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado');
	$diahoje =  new DateTime();
	$diahoje->format('w');
	if ($diahoje->formar('w') == 0) 
	{
		$diasemanahoje = 1;
	}
	else
		if ($diahoje->formar('w') == 1) 
		{
			$diasemanahoje = 2;
		}
		else
			if ($diahoje->formar('w') == 2) 
			{
				$diasemanahoje = 3;
			}
			else
				if ($diahoje->formar('w') == 3) 
				{
					$diasemanahoje = 4;
				}
				else
					if ($diahoje->formar('w') == 4) 
					{
						$diasemanahoje = 5;
					}
					else
						if ($diahoje->formar('w') == 5) 
						{
							$diasemanahoje = 6;
						}
						else
						{
							$diasemanahoje = 7;
						}
?>