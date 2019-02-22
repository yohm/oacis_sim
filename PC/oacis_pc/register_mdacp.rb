base_dir = "/home/oacis"

mdacp = Host.find_by_name("mdacp")

# simulator
sim_params = {
  name: "MDACP_Langevin",
  command: "python #{base_dir}/mdacp/run.py",
  support_input_json: false,
  support_omp: true,
  support_mpi: true,
  parameter_definitions: [
    {key: "density", type: "Float", default: 0.7, description: ""}, 
    {key: "temperature", type: "Float", default: 0.9, description: "aimed temperature of the heat bath"}, 
    {key: "length", type: "Float", default: 20.0, description: ""}, 
    {key: "total_loop", type: "Integer", default: 5000, description: ""}
  ],
  description: "MDACP Langevin heat bath",
  executable_on: [ mdacp ]
}

sim_name = sim_params[:name]
if Simulator.where(name: sim_name).exists?
  puts "simulator #{sim_name} already exists" 
else
  sim = Simulator.create!(sim_params)
end

# analyzer

