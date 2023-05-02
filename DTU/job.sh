for s in \
"Inv_H2_Local_1.0x_bin" \
"Inv_H2_Local_1.0x_cont" \
"Inv_H2_Local_1.5x_bin" \
"Inv_H2_Local_2.0x_bin" \
"Inv_H2_Local_2.0x_cont" \
"Inv_H2_PPA_1.0x_bin" \
"Inv_H2_PPA_1.0x_cont" \
"Inv_H2_PPA_1.5x_bin" \
"Inv_H2_PPA_2.0x_bin" \
"Inv_H2_PPA_2.0x_cont" \
"Inv_MeOH_PPA_1.0x_bin" \
"Inv_MeOH_PPA_1.0x_bin_opt" \
"Inv_MeOH_PPA_1.0x_cont" \
"Inv_MeOH_PPA_1.5x_bin" \
"Inv_MeOH_PPA_2.0x_bin" \
"Inv_MeOH_PPA_2.0x_cont" \
"Inv_NH3_PPA_1.0x_bin" \
"Inv_NH3_PPA_1.0x_bin_opt" \
"Inv_NH3_PPA_1.0x_cont" \
"Inv_NH3_PPA_1.5x_bin" \
"Inv_NH3_PPA_2.0x_bin" \
"Inv_NH3_PPA_2.0x_cont" \
; do
   bsub -env scenario=$s < submit.sh
done
