base_dir = "/home/oacis"

ffb = Host.find_by_name("ffb")

# simulator
sim_params = {
  name: "FFB_Cavity",
  command: "./run.sh",
  pre_process_script: "~/ffb/bin/prepare.sh",
  support_input_json: true,
  support_omp: true,
  support_mpi: true,
  parameter_definitions: [
    {key: "MESHDV", type: "Integer", default: 1,
     description: "Number of divided mesh data"}, 
    {key: "MESHSZ", type: "Integer", default: 1,
     description: "Mesh size of single node (1:small, 2:middle, 3:large)"}, 
    {key: "VISCM", type: "Float", default: 1E-3,
     description: "Kinematic viscosity coefficient"}, 
    {key: "NTIME", type: "Integer", default: 100,
     description: "Number of calculation steps"}
  ],
  description: "FlontFlow/Blue Cavity-flow problem",
  executable_on: [ ffb ]
}

sim_name = sim_params[:name]
if Simulator.where(name: sim_name).exists?
  puts "simulator #{sim_name} already exists" 
else
  sim = Simulator.create!(sim_params)
end

# analyzer

