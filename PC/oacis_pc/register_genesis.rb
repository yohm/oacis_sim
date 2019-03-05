base_dir = "/home/oacis"

genesis = Host.find_by_name("genesis")

# simulator
sim_params = {
  name: "GENESIS_Tutorial1",
  command: "./run.sh",
  pre_process_script: "~/genesis/bin/prepare.sh",
  support_input_json: true,
  support_omp: true,
  support_mpi: true,
  parameter_definitions: [
    {key: "temp_case", type: "Integer", default: 3,
     description: "Temperature case (1:250K, 2:275K, 3:300K, 4:325K, 5:350K)"}, 
    {key: "pres_case", type: "Integer", default: 3,
     description: "Pressure case (1:0.8atm, 2:0.9atm, 3:1.0atm, 4:1.1atm, 5:1.2atm)"}, 
    {key: "nsteps", type: "Integer", default: 2000,
     description: "Number of MD steps"}, 
    {key: "timestep", type: "Float", default: 0.002,
     description: "timestep (ps)"}
  ],
  description: "All-atom MD simulation of BPTI in NaCl solution",
  executable_on: [ genesis ]
}

sim_name = sim_params[:name]
if Simulator.where(name: sim_name).exists?
  puts "simulator #{sim_name} already exists" 
else
  sim = Simulator.create!(sim_params)
end

# analyzer

