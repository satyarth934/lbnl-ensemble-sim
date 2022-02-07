<amanzi_input type="unstructured" version="2.3.0">
    <echo_translated_input format="unstructured_native" file_name="oldspec.xml"/>

    <model_description name="FArea 3D Unsaturated w/ barriers">
      <author>Zexuan Xu, Haruko Wainwright</author>
      <model_id>FArea_U3D</model_id>
      <units>
        <length_unit>m</length_unit>
        <time_unit>s</time_unit>
        <mass_unit>kg</mass_unit>
        <conc_unit>molar</conc_unit>
      </units>
      <comments>FArea 3D Unsaturated w/ barriersMon Jan 12 00:29:50 PST 2015 Summer 2014, new mesh from Terry Miller: https://meshing.lanl.gov/proj/ASCEM_FBasin/index.html </comments>
    </model_description>

    <definitions>
      <macros>
        <time_macro name="Time Output Phase 1">
          <start>1954.0 y</start>
          <timestep_interval>60.0 d</timestep_interval>
          <stop>1956.0 y</stop>
        </time_macro>
        <time_macro name="Time Output Phase 2">
          <start>1956.0 y</start>
          <timestep_interval>1.0 y</timestep_interval>
          <stop>2000.0 y</stop>
        </time_macro>
        <time_macro name="Time Output Phase 3">
          <start>2000.0 y</start>
          <timestep_interval>10.0 y</timestep_interval>
          <stop>2100.0 y</stop>
        </time_macro>
        <cycle_macro name="Every_500_timesteps">
          <start>0</start>
          <timestep_interval>50</timestep_interval>
        </cycle_macro>
        <time_macro name="Every year">
          <start>1956.0 y</start>
          <timestep_interval>1.0 y</timestep_interval>
          <stop>2100.0 y</stop>
        </time_macro>
        <time_macro name="Every five year">
          <start>1956.0 y</start>
          <timestep_interval>5.0 y</timestep_interval>
          <stop>2100.0 y</stop>
        </time_macro>
        <time_macro name="Check">
          <start>1996.0 y</start>
          <timestep_interval>2.0 y</timestep_interval>
          <stop>2006.0 y</stop>
        </time_macro>
        <time_macro name="Every two month">
          <start>1954.01 y</start>
          <timestep_interval>5.184e+06</timestep_interval>
          <stop>2100.0 y</stop>
        </time_macro>
      </macros>
    </definitions>

    <process_kernels>
      <comments>This is a proposed comment field for process_kernels</comments>
      <flow model="richards" state="on" />

      <transport state="on" />
      <chemistry engine="amanzi" process_model="none" state="on" input_filename="../shared_files/farea_tritium.bdg"/>
    </process_kernels>

    <phases>
      <comments>Eliminated term "Uniform" from viscosity and density input. Designed for additional phases to be included.</comments>
      <liquid_phase name="water">
        <eos>false</eos>
          <viscosity>0.001002</viscosity>
        <density>998.2</density>

        <dissolved_components>
          <solutes>
            <solute coefficient_of_diffusion="0.0">Tritium</solute>
          </solutes>
        </dissolved_components>

      </liquid_phase>
    </phases>


    <geochemistry>
      <amanzi_chemistry>
        <reaction_network file="../shared_files/farea_tritium.bdg" format="simple"/>
      </amanzi_chemistry>
    </geochemistry>


    <execution_controls>
      <verbosity level="high" />

    <execution_control_defaults init_dt="1.0" method="picard" mode="steady" />
    <execution_control end="2020,y" mode="transient" start="1954,y" init_dt="60.0" />

      <restart>../shared_files/checkpoint00095.h5</restart>
    </execution_controls>

    <numerical_controls>
      <unstructured_controls>
        <unstr_flow_controls>
          <preconditioning_strategy>linearized_operator</preconditioning_strategy>
        </unstr_flow_controls>

        <unstr_steady-state_controls>
          <min_iterations>15</min_iterations>
          <max_iterations>20</max_iterations>
          <max_preconditioner_lag_iterations>0</max_preconditioner_lag_iterations>
          <nonlinear_tolerance>1.0e-5</nonlinear_tolerance>
          <limit_iterations>20</limit_iterations>
          <nonlinear_iteration_damping_factor>1</nonlinear_iteration_damping_factor>
          <nonlinear_iteration_divergence_factor>1000</nonlinear_iteration_divergence_factor>
          <restart_tolerance_relaxation_factor>500</restart_tolerance_relaxation_factor>
          <restart_tolerance_relaxation_factor_damping>0.9</restart_tolerance_relaxation_factor_damping>
          <max_divergent_iterations>3</max_divergent_iterations>
          <unstr_initialization>
            <clipping_pressure>90000.0</clipping_pressure>
            <preconditioner>hypre_amg</preconditioner>
            <linear_solver>AztecOO</linear_solver>
            <control_options>pressure</control_options>
            <convergence_tolerance>1.0e-8</convergence_tolerance>
            <max_iterations>100</max_iterations>
          </unstr_initialization>
        </unstr_steady-state_controls>

        <unstr_transient_controls>
            <limit_iterations>20</limit_iterations>
            <nonlinear_iteration_divergence_factor>1000</nonlinear_iteration_divergence_factor>
            <nonlinear_tolerance>1.0e-5</nonlinear_tolerance>
            <min_iterations>10</min_iterations>
            <max_divergent_iterations>3</max_divergent_iterations>
            <restart_tolerance_relaxation_factor>1</restart_tolerance_relaxation_factor>
            <nonlinear_iteration_damping_factor>1</nonlinear_iteration_damping_factor>
            <max_preconditioner_lag_iterations>0</max_preconditioner_lag_iterations>
            <initialize_with_darcy>true</initialize_with_darcy>
            <max_iterations>15</max_iterations>
          <preconditioner>hypre_amg</preconditioner>
        </unstr_transient_controls>

        <unstr_linear_solver>
          <max_iterations>100</max_iterations>
          <tolerance>1e-20</tolerance>
        </unstr_linear_solver>

        <unstr_transport_controls>
          <algorithm>explicit first-order</algorithm>
          <cfl>1.0</cfl>
          <sub_cycling>on</sub_cycling>
        </unstr_transport_controls>
        
        <unstr_preconditioners>
          <hypre_amg>
            <!--hypre_tolerance>1e-2</hypre_tolerance-->
          </hypre_amg>
          <trilinos_ml />
          <block_ilu />
        </unstr_preconditioners>
      </unstructured_controls>
    </numerical_controls>

    <mesh framework="mstk">
      <comments>Read from Exodus II</comments>
      <dimension>3</dimension>
      <read>
        <file>../shared_files/farea_3D_barriers.exo</file>
        <format>exodus ii</format>
      </read>
    </mesh>

    <regions>
      <region name="Upper_aquifer">
        <region_file entity="cell" format="exodus ii" label="3" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="Lower_aquifer">
        <region_file entity="cell" format="exodus ii" label="1" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="Tan_clay">
        <region_file entity="cell" format="exodus ii" label="2" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="Basin3">
        <region_file entity="cell" format="exodus ii" label="4" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="Basin2">
        <region_file entity="cell" format="exodus ii" label="5" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="Basin1">
        <region_file entity="cell" format="exodus ii" label="6" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="Barrier1">
        <region_file entity="cell" format="exodus ii" label="7" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="Barrier2">
        <region_file entity="cell" format="exodus ii" label="8" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="Barrier3">
        <region_file entity="cell" format="exodus ii" label="9" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="Barrier4">
        <region_file entity="cell" format="exodus ii" label="10" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="Barrier5">
        <region_file entity="cell" format="exodus ii" label="11" name="farea_3D_barriers.exo" type="labeled set" />
      </region>

      <region name="TopBarrier1">
        <region_file entity="cell" format="exodus ii" label="12" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="TopBarrier2">
        <region_file entity="cell" format="exodus ii" label="13" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="TopBarrier3">
        <region_file entity="cell" format="exodus ii" label="14" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="TopBarrier4">
        <region_file entity="cell" format="exodus ii" label="15" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="TopBarrier5">
        <region_file entity="cell" format="exodus ii" label="16" name="farea_3D_barriers.exo" type="labeled set" />
      </region>

      <region name="Ground_surface">
        <region_file entity="face" format="exodus ii" label="6" name="farea_3D_barriers.exo" type="labeled set" />
      </region>

      <region name="Basin_surface3">
        <region_file entity="face" format="exodus ii" label="8" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="Basin_surface2">
        <region_file entity="face" format="exodus ii" label="9" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="Basin_surface1">
        <region_file entity="face" format="exodus ii" label="10" name="farea_3D_barriers.exo" type="labeled set" />
      </region>

      <region name="FaceBarrier1">
        <region_file entity="face" format="exodus ii" label="11" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="FaceBarrier2">
        <region_file entity="face" format="exodus ii" label="12" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="FaceBarrier3">
        <region_file entity="face" format="exodus ii" label="13" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="FaceBarrier4">
        <region_file entity="face" format="exodus ii" label="14" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="FaceBarrier5">
        <region_file entity="face" format="exodus ii" label="15" name="farea_3D_barriers.exo" type="labeled set" />
      </region>

      <region name="Lateral1">
        <region_file entity="face" format="exodus ii" label="4" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="Lateral2">
        <region_file entity="face" format="exodus ii" label="2" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="Gordon_boundary">
        <region_file entity="face" format="exodus ii" label="1" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="Upstream">
        <region_file entity="face" format="exodus ii" label="3" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <region name="River">
        <region_file entity="face" format="exodus ii" label="5" name="farea_3D_barriers.exo" type="labeled set" />
      </region>
      <point name="FSB95DR" coordinate =  "15238.7808,  22857.47016,  60.0456" />
      <point name="FSB110D" coordinate =  "15283.15968,  22614.11784,  61.29528 " />
        <!-- Haruko -->
    </regions>

    <materials>
      <material name="UUTRA">
        <comments>UUTRA</comments>
        <mechanical_properties>
          <porosity value="@Por@" />
          <particle_density value="2720.0" />
        </mechanical_properties>

        <permeability x="@Perm@" y="@Perm@" z="@Perm@" />
        <cap_pressure model="van_genuchten">
          <parameters alpha="@alpha@" m="0.5" optional_krel_smoothing_interval="500.0" sr="0.18" />
        </cap_pressure>
        <rel_perm model="mualem" />
        <assigned_regions>Upper_aquifer,Basin1,Basin2,Basin3,TopBarrier1,TopBarrier2,TopBarrier3,TopBarrier4,TopBarrier5</assigned_regions>
      </material>


      <material name="BARRIERS">
        <comments>BARRIES</comments>
        <mechanical_properties>
          <porosity value="0.39" />
          <particle_density value="2720.0" />
        </mechanical_properties>
        
        <permeability x="9.0E-12" y="9.0E-12" z="9.0E-12" />
        <cap_pressure model="van_genuchten">
          <parameters alpha="4.0E-4" m="0.5" optional_krel_smoothing_interval="500.0" sr="0.18" />
        </cap_pressure>
        <rel_perm model="mualem" />
        <assigned_regions>Barrier1,Barrier2,Barrier3,Barrier4,Barrier5</assigned_regions>
      </material>


      <material name="TCCZ">
        <comments>TCCZ</comments>
        <mechanical_properties>
          <porosity value="0.39" />
          <particle_density value="2720.0" />
        </mechanical_properties>
        
        <permeability x="1.98E-14" y="1.98E-14" z="1.98E-14" />
        <cap_pressure model="van_genuchten">
          <parameters alpha="5.1E-5" m="0.5" optional_krel_smoothing_interval="500.0" sr="0.39" />
        </cap_pressure>
        <rel_perm model="mualem" />
        <assigned_regions>Tan_clay</assigned_regions>
      </material>

      <material name="LUTRA">
        <comments>LUTRA</comments>
        <mechanical_properties>
          <porosity value="0.39" />
          <particle_density value="2720.0" />
        </mechanical_properties>
        
        <permeability x="5.0E-12" y="5.0E-12" z="5.0E-12" />
        <cap_pressure model="van_genuchten">
          <parameters alpha="5.1E-5" m="0.5" optional_krel_smoothing_interval="500.0" sr="0.41" />
        </cap_pressure>
        <rel_perm model="mualem" />
        <assigned_regions>Lower_aquifer</assigned_regions>
      </material>
    </materials>

    <initial_conditions>
      <initial_condition name="Pressure and concentration for entire domain">
        <comments>Initial Conditions Comments</comments>
        <assigned_regions>Upper_aquifer,Lower_aquifer,Tan_clay,Basin1,Basin2,Basin3,TopBarrier1,TopBarrier2,TopBarrier3,TopBarrier4,TopBarrier5,Barrier1,Barrier2,Barrier3,Barrier4,Barrier5</assigned_regions>
        <liquid_phase name="water">
          <liquid_component name="water">
            <linear_pressure gradient="0.0, 0.0, -9790.174828" reference_coord="0.0, 0.0, 67.7" value="101325" />
          </liquid_component>
          <solute_component>
            <uniform_conc name="Tritium" value="1.0e-20" function="constant" start="0.0"/>
          </solute_component>

<!--
          <geochemistry_component>
            <constraint name="background"/>
          </geochemistry_component>
-->
        </liquid_phase>
      </initial_condition>
    </initial_conditions>

    <boundary_conditions>
      <boundary_condition name="Natural recharge">
        <assigned_regions>Ground_surface</assigned_regions>
        <liquid_phase name="water">
          <liquid_component name="water">
            <seepage_face function="constant" inward_mass_flux="@Rech@" start="0.0 y" />
          </liquid_component>
          <solute_component>
            <uniform_conc name="Tritium" value="1.0e-20" function="constant" start="0.0"/>
          </solute_component>

<!--
          <geochemistry_component>
            <constraint function="constant" name="recharge" start="0.0 y"/>
          </geochemistry_component>
-->
        </liquid_phase>
      </boundary_condition>

      <boundary_condition name="Barrier recharge">
        <assigned_regions>FaceBarrier1,FaceBarrier2,FaceBarrier3,FaceBarrier4,FaceBarrier5</assigned_regions>
        <liquid_phase name="water">
          <liquid_component name="water">
            <inward_mass_flux function="constant" start="0.0 y" value="4.743e-10" />
          </liquid_component>
          <solute_component>
            <uniform_conc name="Tritium" value="1.0e-20" function="constant" start="0.0"/>
          </solute_component>

<!--
          <geochemistry_component>
            <constraint function="constant" name="recharge" start="0.0 y"/>
          </geochemistry_component>
-->
        </liquid_phase>
      </boundary_condition>

      <boundary_condition name="Basin recharge">
        <assigned_regions>Basin_surface3,Basin_surface2,Basin_surface1</assigned_regions>
        <liquid_phase name="water">
          <liquid_component name="water">
            <inward_mass_flux function="constant" start="0.0 y" value="4.743e-06" />
            <inward_mass_flux function="constant" start="1954.0 y" value="@seepage@" />
            <inward_mass_flux function="constant" start="1988.0 y" value="0.0" />
          </liquid_component>
        <solute_component>
          <aqueous_conc name="Tritium" value="1.0e-20" function="constant" start="0.0"/>
          <aqueous_conc name="Tritium" value="2.17e-09" function="constant" start="6.16635504e+10"/>
          <aqueous_conc name="Tritium" value="1.0e-20" function="constant" start="6.27365088e+10"/>
       </solute_component> 
       
        </liquid_phase>
      </boundary_condition>

      <boundary_condition name="No flow above water table">
        <assigned_regions>Upstream</assigned_regions>
        <liquid_phase name="water">
          <liquid_component name="water">
            <hydrostatic coordinate_system="absolute" function="constant" start="0.0 y" value="67.7" />
          </liquid_component>
          <solute_component>
            <aqueous_conc name="Tritium" value="1.0e-20" function="constant" start="0.0"/>
          </solute_component> 
        </liquid_phase>
      </boundary_condition>

    </boundary_conditions>

    <output>
      <observations>
        <filename>observation1.out</filename>
        <liquid_phase name="water">

          <solute_volumetric_flow_rate solute="Tritium">
            <assigned_regions>Ground_surface</assigned_regions>
            <functional>integral</functional>
            <time_macros>Every two month</time_macros>
          </solute_volumetric_flow_rate>
           
            <aqueous_conc solute="Tritium">
            <assigned_regions>FSB95DR</assigned_regions>
            <functional>point</functional>
            <time_macros>Every two month</time_macros>
          </aqueous_conc>
          <aqueous_conc solute="Tritium">
            <assigned_regions>FSB110D</assigned_regions>
            <functional>point</functional>
            <time_macros>Every two month</time_macros>
          </aqueous_conc>

<!-- Haruko -->                          
          </liquid_phase>
     </observations>

      <vis>
        <base_filename>plot</base_filename>
        <num_digits>5</num_digits>
        <time_macros>Every year</time_macros>
	<write_regions>Upper_aquifer,Lower_aquifer,Tan_clay,Basin1,Basin2,Basin3,TopBarrier1,
                       TopBarrier2,TopBarrier3,TopBarrier4,TopBarrier5,Barrier1,Barrier2,Barrier3,Barrier4,Barrier5</write_regions>

        <blacklist>alquimia_aux.*,free_ion.*,primary.*,secondary.*,ion_exchange_ref.*,mineral_reaction.*,mineral_specific.*,mineral_rate_constant.*,mineral_saturation_index.*,mineral_specific_surface_area.*,mineral_volumn_fractions.*</blacklist>
      </vis>

      <checkpoint>
        <base_filename>checkpoint</base_filename>
        <num_digits>5</num_digits>
        <time_macros>Every five year</time_macros>
      </checkpoint>

    </output>
  </amanzi_input>
