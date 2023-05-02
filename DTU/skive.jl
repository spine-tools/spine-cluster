using Pkg
Pkg.activate(pwd())
using SpineOpt

scenario=ENV["scenario"]
job=ENV["job"]
comment=ENV["comment"]
db_url_in =  "sqlite:///output/input/$(job)-input.sqlite"
db_url_out = "sqlite:///output/output.sqlite"

println("______________________________________")
println("Job: $(job)")
println("Scenario: $(scenario)")
println("Specifics: $(comment)")
println("______________________________________")

m=run_spineopt(
                db_url_in, 
                db_url_out, 
                filters=Dict("tool"=>"object_activity_control", 
                            "scenario" => "$(scenario)"),
                alternative="$(scenario)_$(job)$(comment)",
                #log_file_path="output/log_$(job)_$(scenario)$(comment).txt"
)

# Write model file to folder .julia/packages/SpineOpt/src/utils
# SpineOpt.write_model_file(m; file_name="models/model_$(job)_$(scenario)_$(comment)")
