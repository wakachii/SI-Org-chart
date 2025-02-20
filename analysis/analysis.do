import delimited "/Users/satoshan/Library/CloudStorage/GoogleDrive-sato41kawa0707@gmail.com/マイドライブ/scan_org_charts/data/clean/data.csv", clear
rename lngrossoutput ln_gross_output
rename lnintermediateinput ln_intermediate_input
rename lnrealstockofcapitalqualityadjus ln_capital_stock
rename lnlaborinputhoursworkedandlaborq ln_labor_input
rename costshareofcapitalinput cost_share_capital_input
rename costshareoflaborinput cost_share_labor_input
rename costshareofintermediateinput cost_share_intermediate_input
rename multilateraltfpbaseyear2011indus multi_tfp
rename lntfpoutlierincluded ln_tfp
gen JIPcode_num = real(regexs(1)) if regexm(jipcode, "([0-9]+)_")
gen JIPcode_name = regexs(1) if regexm(jipcode, "_(.+)")
gen hierarchy_2 = hierarchy^2
gen ln_gross_output_2 = ln_gross_output^2
gen hierarchy_size = hierarchy * ln_gross_output
gen department_per_hierarchy = num_depart / hierarchy
gen department_per_hierarchy_2 = department_per_hierarchy^2
gen department_per_hierarchy_size = department_per_hierarchy * ln_gross_output
gen ind_3 = 1
replace ind_3 = 0 if JIPcode_num <= 60


twoway ///
    (histogram hierarchy if year == 2002, color(blue%50) width(0.1)) ///
    (histogram hierarchy if year == 2006, color(red%50) width(0.1)), ///
    title("Histogram of H by Year") ///
    xlabel(, grid) ylabel(, grid) ///
    legend(order(1 "Year 2002" 2 "Year 2006")) ///
    xtitle("H (Number of Hierarchies)") ytitle("Frequency")
	gr rename H_hist, replace

scatter ln_tfp hierarchy if ind_3 == 0, title("Manufacturing") ///
    xlabel(, grid) ylabel(, grid) ///
    xtitle("H (Number of Hierarchies)") ytitle("Y (Productivity)")
	gr rename Y_H_manu, replace

scatter ln_tfp hierarchy if ind_3 == 1, title("Service") ///
    xlabel(, grid) ylabel(, grid) ///
    xtitle("H (Number of Hierarchies)") ytitle("Y (Productivity)")
	gr rename Y_H_serv, replace


reg ln_tfp hierarchy hierarchy_2 ln_gross_output ln_gross_output_2 hierarchy_size department_per_hierarchy ln_intermediate_input ln_capital_stock ln_labor_input ind_3
