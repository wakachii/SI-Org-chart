import delimited "/Users/satoshan/Library/CloudStorage/GoogleDrive-sato41kawa0707@gmail.com/マイドライブ/scan_org_charts/data/Org_chart/clean/data.csv", clear
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
drop if hierarchy == 1

twoway ///
    (histogram hierarchy if year == 2002, color(blue%50) width(0.1)) ///
    (histogram hierarchy if year == 2006, color(red%50) width(0.1)) ///
	(histogram hierarchy if year == 2011, color(green%50) width(0.1)), ///
    title("Hierarchy distribution by Year") ///
    xlabel(, grid) ylabel(, grid) ///
    legend(order(1 "2002" 2 "2006" 3 "2011")) ///
    xtitle("H (Number of Hierarchies)") ytitle("Frequency")
	gr rename H_hist, replace
	
twoway ///
    (kdensity hierarchy if year == 2002, lcolor(blue) lwidth(medium)) ///
    (kdensity hierarchy if year == 2006, lcolor(red) lwidth(medium)) ///
    (kdensity hierarchy if year == 2011, lcolor(green) lwidth(medium)), ///
    title("Hierarchy distribution by Year") ///
    xlabel(, grid) ylabel(, grid) ///
    legend(order(1 "2002" 2 "2006" 3 "2011")) ///
    xtitle("H (Number of Hierarchies)") ytitle("Density")
	gr rename H_hist_kd, replace
	
quietly correlate department_per_hierarchy hierarchy
local corr = round(r(rho), 0.01)

twoway ///
    (scatter department_per_hierarchy hierarchy if year == 2002, color(blue)) ///
    (scatter department_per_hierarchy hierarchy if year == 2006, color(red)) ///
    (scatter department_per_hierarchy hierarchy if year == 2011, color(green)), ///
    title("Span of control (Correlation = `corr')") ///
    xlabel(, grid) ylabel(, grid) ///
    ytitle("Department per Hierarchies (Span of control)") ///
    xtitle("H (Number of Hierarchies)")
	gr rename H_S, replace
	
scatter ln_tfp hierarchy if ind_3 == 0, title("Manufacturing") ///
    xlabel(, grid) ylabel(, grid) ///
    xtitle("H (Number of Hierarchies)") ytitle("Productivity")
	gr rename A_H_manu, replace

scatter ln_tfp hierarchy if ind_3 == 1, title("Service") ///
    xlabel(, grid) ylabel(, grid) ///
    xtitle("H (Number of Hierarchies)") ytitle("Productivity")
	gr rename Y_H_serv, replace


reg ln_tfp hierarchy hierarchy_2 department_per_hierarchy department_per_hierarchy_2 hierarchy_size ///
	ln_gross_output ln_intermediate_input ln_capital_stock ln_labor_input i.year i.JIPcode_num
