with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Alea;

--------------------------------------------------------------------------------
--  Auteur   : MORAIN Arthur
--  Objectif : Affronter la machine au jeu de Nim à 13 allumettes avec un niveau demandé par l'utilisateur
--------------------------------------------------------------------------------

procedure Allumettes is
	--Affronter la machine au jeu de Nim à 13 allumettes avec un niveau demandé par l'utilisateur
 	package Alea_1_3 is
    	new Alea (1, 3);
  	use Alea_1_3;

	Niv_jeu : Character ; --le niveau de jeu demandé par l'utilisateur
	Util_deb : Character ; --le joueur qui va commencer la partie
	Nbr_al : Integer; -- le nombre d'allumettes restantes dans la partie
	Joueur_act : Character; --le joueur actuel avec u l'utilisateur et o l'ordinateur
	Nal_tour : Integer; --le nombre d'allumettes prises sur un tour


begin
	--Demander le niveau de jeu à l'utilisateur
	Put("Niveau de l'ordinateur (n)aïf, (d)istrait, (r)apide ou (e)xpert ? ");
	Get(Niv_jeu);


	--Afficher le niveau de jeu demander
	Put("Mon niveau est ");
	case Niv_jeu is
    	when 'n' | 'N' => Put("naïf.") ;
    	when 'r' | 'R' => Put("rapide.") ;
    	when 'd' | 'D' => Put("distrait.");
    	when others => Put("expert.");
	end case ;
	New_line;

	--Demander si l'utilisateur veut commencer la partie
	Put("Est-ce que vous commencez (o/n) ? ");
	Get(Util_deb);

	case Util_deb is --Pour déclarer le premier joueur actuel
        when 'o' | 'O' => Joueur_act := 'u' ;
        when others => Joueur_act := 'o' ;
	end case ;

	Nbr_al := 13;

	while Nbr_al>0 loop

                 --Afficher le nombre d'allumettes restantes
                 New_line;
                 for i in 1..3 loop --Permet de faire les 3 lignes

        		--Afficher les allumettes par paquets de 5 maximum
        		for i in 1..Nbr_al loop
            		   if i=5 or i=10 then
                		Put("| ");
                		Put(" ");
            		   else
                		Put("| ");
            		   end if;
        		end loop;
                        New_line;
                end loop;
                New_line;

        	--Jouer le tour du joueur actuel
        	if Joueur_act='u' then

                	--Jouer le tour de l'utilisateur
                	Put("Combien d'allumettes prenez-vous ? ");
                	Get(Nal_tour);

                	while Nal_tour<=0 or Nal_tour>3 or (Nbr_al-Nal_tour)<0 loop --permet de vérifier que les 3 règles sont respectées

                        	--Demander de respecter la règle non respectée pour la nouvelle demande
                        	if Nal_tour<=0 then
                                        Put_line("Arbitre : Il faut prendre au moins une allumette.");
                                	Put("Combien d'allumettes prenez-vous ? ");
                                	Get(Nal_tour);

                                elsif Nal_tour>3 then

                                	Put_line("Arbitre: Il est interdit de prendre plus de 3 allumettes.");
                                	Put("Combien d'allumettes prenez-vous ? ");
                                	Get(Nal_tour);


                        	else

                                	--Demander à l'utilisateur un nombre cohérent d'allumettes
                                	if Nbr_al=2 then

                                        	Put_line("Arbitre: Il reste seulement 2 allumettes.");
                                        	Put("Combien d'allumettes prenez-vous ? ");
                                        	Get(Nal_tour);

                                	else
                                                Put_line("Arbitre: Il reste une seule allumette.");
                                        	Put("Combien d'allumettes prenez-vous ? ");
                                         	Get(Nal_tour);

                                	end if;

                        
                        	end if;

                	end loop;
                        New_line;
                	Nbr_al := Nbr_al - Nal_tour;--On retire le nombre d'allumettes prises par l'utilisateur

                	Joueur_act := 'o';--on change de joueur actuel pour le prochain tour

         	else

                	--Calculer le nombre d’allumettes à retirer au niveau demandé
                	case Niv_jeu is
                 	when 'n' | 'N' =>

                        	--Calculer le nombre d’allumettes à retirer au niveau naif
                        	if Nbr_al>=3 then
                         	        Get_Random_Number (Nal_tour);
                        	elsif Nbr_al=2 then
                         	        Nal_tour := 2;
                        	else
                         	        Nal_tour := 1;

                        	end if;


                 	when 'd' | 'D' =>

                        	--Calculer le nombre d’allumettes à retirer au niveau distrait
                        	Get_Random_Number (Nal_tour);
                        	while (Nbr_al-Nal_tour)<0 loop
                        	       if Nal_tour = 2 then
                                              Put("Je prends 2 allumettes.");
                                       else
                                              Put("Je prends 3 allumettes.");
                                       end if;
                                       New_line;
                    	                --Contrôler le nombre d’allumettes à retirer
                                       if Nbr_al=2 then
                                              Put_line("Arbitre: Il reste seulement 2 allumettes.");
                                              Nal_tour := 2;

                                       else
                                	      Put_line("Arbitre: Il reste une seule allumette.");
                                	      Nal_tour := 1;
                        	      end if;
                	      end loop;


            	        when 'r' | 'R' =>

                	        --Calculer le nombre d’allumettes à retirer au niveau rapide
                	        if Nbr_al>=3 then
                                	Nal_tour:=3;
                	        elsif Nbr_al=2 then
                        	        Nal_tour:=2;
                	        else
                        	        Nal_tour:=1;
                	        end if;

            	        when others =>

                	        --Calculer le nombre d’allumettes à retirer au niveau expert
                	        if ((Nbr_al-1) mod 4)=0 then
                            	                Get_Random_Number (Nal_tour) ;

                             	                --Contrôler le nombre d’allumettes à retirer
                            	                if Nbr_al=2 then
                            	                        Put_line("Je prends 3 allumettes.");
                                                        Put("Arbitre: Il reste seulement 2 allumettes.");
                                                        Nal_tour := 2;
                                                        New_Line;

                            	                elsif Nbr_al=1 then
                            	                        if Nal_tour = 1 then
                                                                Put_line("Je prends 1 allumette.");
                                                                Put("Arbitre: Il reste une seule allumette.");
                                                                New_Line;
                                                                Nal_tour := 1;


                                                        elsif Nal_tour = 2 then
                                                                Put_line("Je prends 2 allumettes.");
                                                                Put("Arbitre: Il reste une seule allumette.");
                                                                New_Line;
                                                                Nal_tour := 1;
                                                       end if;
                            	                end if;

                            --Choisir un nombre d'allumettes pour qu'il n'en reste qu'une
                            elsif Nbr_al<=4 then
                            	                Nal_tour := Nbr_al - 1;

                        	else

                            --Choisir un nombre d'allumettes de sorte que le reste soit un multiple de 4 +1
                  	                Nal_tour:= 1;
                                	  while not (((Nbr_al-Nal_tour-1) mod 4)=0) loop
                                        	        Nal_tour := Nal_tour + 1 ;
                                	  end loop;
                        	end if;

            	        end case;

            	        Nbr_al := Nbr_al-Nal_tour;--on retire les allumettes prises par l'ordinateur
            	        Joueur_act := 'u' ; --on change de joueur actuel pour le prochain tour
            	        if Nal_tour = 1 then
                                Put_line("Je prends 1 allumette.");

                        elsif Nal_tour = 2 then
                                Put_line("Je prends 2 allumettes.");

                        else
                                Put_line("Je prends 3 allumettes.");

                        end if;
        	end if;
    	end loop;
        New_line;
    	--Afficher le gagnant
    	if Joueur_act ='u' then
        	Put("Vous avez gagné.");
    	else
        	Put("J'ai gagné.");
    	end if;

end Allumettes;





