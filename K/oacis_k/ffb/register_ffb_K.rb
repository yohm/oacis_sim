khost = Host.find_by_name("K")

# simulator
sim_params = {
  name: "FFB_Cavity",
  pre_process_script: "~/oacis_ffb/bin/prepare.sh",
  command: "./xrun.sh",
  support_input_json: true,
  support_omp: true,
  support_mpi: true,
  parameter_definitions: [
    {key: "MESHDV", type: "Integer", default: 1,
     description: "The overall size of the calculation area. Specify that the calculation should be performed in the area of MESHDV units with a rectangular unit with one side as the basic unit. (select a number from {1, 2, 4, 8}, must be the same number as MPI procs)"}, 
    {key: "MESHSZ", type: "Integer", default: 1,
     description: "Specify how many elements to divide a rectangular parallelepiped with one side at one. (1:23x23x23, 2:46x46x46, 3:92x92x92)"}, 
    {key: "VISCM", type: "Float", default: 1E-3,
     description: "Kinematic viscosity coefficient"}, 
    {key: "NTIME", type: "Integer", default: 100,
     description: "Number of calculation steps"}
  ],
  description: "FlontFlow/Blue Cavity-flow problem",
  executable_on: [ khost ]
}

sim_name = sim_params[:name]
if Simulator.where(name: sim_name).exists?
  puts "simulator #{sim_name} already exists" 
else
  sim = Simulator.create!(sim_params)
end

# analyzer
