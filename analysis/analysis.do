import excel "/Users/satoshan/Library/CloudStorage/GoogleDrive-sato41kawa0707@gmail.com/マイドライブ/SI-Org-Chart/data/JLCP/jlcp2021.xlsx", sheet("Sheet1") firstrow clear

rename (Performanceyear Stockcode) (year code)
tempfile temp_jlcp
save `temp_jlcp', replace

import delimited "/Users/satoshan/Library/CloudStorage/GoogleDrive-sato41kawa0707@gmail.com/マイドライブ/SI-Org-Chart/data/Org_chart/clean/org_data.csv", clear
merge 1:1 code year using `temp_jlcp'
drop if _merge != 3
drop _merge
gen hierarchy = shortest_path_length + 1

rename lngrossoutput ln_gross_output
rename lnintermediateinput ln_intermediate_input
rename lnrealstockofcapitalqualit ln_capital_stock
rename lnlaborinputhoursworkedand ln_labor_input
rename costshareofcapitalinput cost_share_capital_input
rename costshareoflaborinput cost_share_labor_input
rename costshareofintermediateinput cost_share_intermediate_input
rename MultilateralTFPbaseyear2011 multi_tfp
rename lnTFPoutlierincluded ln_tfp
gen JIPcode_num = real(regexs(1)) if regexm(JIPcode, "([0-9]+)_")
gen JIPcode_name = regexs(1) if regexm(JIPcode, "_(.+)")

// keep 
bysort code (year): gen year_count = _N   
keep if year_count == 3

// generate variables
gen hierarchy_2 = hierarchy^2
gen ln_gross_output_2 = ln_gross_output^2
gen hierarchy_size = hierarchy * ln_gross_output
gen department_per_hierarchy = num_depart / hierarchy
gen department_per_hierarchy_2 = department_per_hierarchy^2
gen department_per_hierarchy_size = department_per_hierarchy * ln_gross_output
gen ind_3 = 0
replace ind_3 = 1 if (JIPcode_num <= 5)
replace ind_3 = 2 if (JIPcode_num <= 60) & (JIPcode_num > 5)
replace ind_3 = 3 if (JIPcode_num > 60)
drop if hierarchy == 1

twoway ///
    (histogram hierarchy if year == 2002, color(blue%50) width(0.1)) ///
    (histogram hierarchy if year == 2006, color(red%50) width(0.1)) ///
	(histogram hierarchy if year == 2010, color(green%50) width(0.1)), ///
    title("Hierarchy distribution by Year") ///
    xlabel(, grid) ylabel(, grid) ///
    legend(order(1 "2002" 2 "2006" 3 "2010")) ///
    xtitle("H (Number of Hierarchies)") ytitle("Frequency")
	gr rename H_hist, replace
	
twoway ///
    (kdensity hierarchy if year == 2002, lcolor(blue) lwidth(medium)) ///
    (kdensity hierarchy if year == 2006, lcolor(red) lwidth(medium)) ///
    (kdensity hierarchy if year == 2010, lcolor(green) lwidth(medium)), ///
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
    (scatter department_per_hierarchy hierarchy if year == 2010, color(green)), ///
    title("Span of control (Correlation = `corr')") ///
    xlabel(, grid) ylabel(, grid) ///
    ytitle("Department per Hierarchies (Span of control)") ///
    xtitle("H (Number of Hierarchies)")
	gr rename H_S, replace
	
scatter ln_tfp hierarchy if ind_3 == 2, title("Manufacturing") ///
    xlabel(, grid) ylabel(, grid) ///
    xtitle("H (Number of Hierarchies)") ytitle("Productivity")
	gr rename A_H_manu, replace

scatter ln_tfp hierarchy if ind_3 == 3, title("Service") ///
    xlabel(, grid) ylabel(, grid) ///
    xtitle("H (Number of Hierarchies)") ytitle("Productivity")
	gr rename Y_H_serv, replace


reg ln_tfp hierarchy hierarchy_2 department_per_hierarchy department_per_hierarchy_2 hierarchy_size ///
	ln_gross_output ln_intermediate_input ln_capital_stock ln_labor_input i.year i.JIPcode_num

preserve
drop if year == 2010
ksmirnov hierarchy, by(year)
ttest hierarchy, by(year)
restore

preserve
drop if year == 2002
ksmirnov hierarchy, by(year)
ttest hierarchy, by(year)
restore
