function [ output_args ] = ezpadova_help( input_args )
%EZPADOVA_HELP Summary of this function goes here
%   Detailed explanation goes here


end

%% translated keywords arguments

% #################################################
% #########  default arguments  ###################
% #################################################
%             'binary_frac': 0.3,
%             'binary_kind': 1,
%             'binary_mrinf': 0.7,
%             'binary_mrsup': 1,
%             'cmd_version': 2.3,
%        ***  'dust_source': 'nodust',
%        ***  'dust_sourceC': 'AMCSIC15',
%        ***  'dust_sourceM': 'dpmod60alox40',
%             'eta_reimers': 0.2,
%             'extinction_av': 0,
%             'icm_lim': 4,
%             'imf_file': 'tab_imf/imf_chabrier_lognormal.dat',
%             'isoc_age': 1e7,
%             'isoc_age0': 12.7e9,
%             'isoc_dlage': 0.05,
%             'isoc_dz': 0.0001,
%        ***  'isoc_kind': 'parsec_CAF09_v1.2S',
%             'isoc_lage0': 6.6,
%             'isoc_lage1': 10.13,
%        ***  'isoc_val': 0,
%             'isoc_z0': 0.0001,
%             'isoc_z1': 0.03,
%             'isoc_zeta': 0.02,
%             'isoc_zeta0': 0.008,
%        ***  'kind_cspecmag': 'aringer09',
%             'kind_dust': 0,
%        ***  'kind_interp': 1,
%             'kind_mag': 2,
%             'kind_postagb': -1,
%             'kind_pulsecycle': 0,
%             'kind_tpagb': 3,
%             'lf_deltamag': 0.2,
%             'lf_maginf': 20,
%             'lf_magsup': -20,
%             'mag_lim': 26,
%             'mag_res': 0.1,
%             'output_evstage': 0,
%             'output_gzip': 0,
%             'output_kind': 0,
%             'photsys_file': 'tab_mag_odfnew/tab_mag_bessell.dat',
%             'photsys_version': 'yang',
%             'submit_form': 'Submit'





%% ezpadova website
% https://github.com/hypergravity/ezpadova
% https://github.com/mfouesneau/ezpadova

% for keywords, see:
% https://github.com/mfouesneau/ezpadova/blob/master/cmd.py

%%
% Signature: cmd.get_one_isochrone(age, metal, ret_table=True, **kwargs)
% Docstring:
% get one isochrone at a given time and Z
% 
% Parameters
% ----------
% 
% age: float
%     age of the isochrone (in yr)
% 
% metal: float
%     metalicity of the isochrone
% 
% ret_table: bool
%     if set, return a eztable.Table object of the data
% 
% model: str
%     select the type of model :func:`help_models`
% 
% carbon: str
%     carbon stars model :func:`help_carbon_stars`
% 
% interp: str
%     interpolation scheme
% 
% dust: str
%     circumstellar dust prescription :func:`help_circumdust`
% 
% Mstars: str
%     dust on M stars :func:`help_circumdust`
% 
% Cstars: str
%     dust on C stars :func:`help_circumdust`
% 
% phot: str
%     photometric set for photometry values :func:`help_phot`
% 
% Returns
% -------
% r: Table or str
%     if ret_table is set, return a eztable.Table object of the data
%     else return the string content of the data
% File:      ~/PycharmProjects/bopy/bopy/helpers/ezpadova/cmd.py
% Type:      function


%% Available model interfaces
% 
% parsec12s: PARSEC version 1.2S, Tang et al. (2014), Chen et al. (2014)
% 
% parsec11: PARSEC version 1.1, With revised diffusion+overshooting in low-mass stars, and improvements in interpolation scheme.
% 
% parsec10: PARSEC version 1.0
% 
% 2010: Marigo et al. (2008) with the Girardi et al. (2010) Case A correction for low-mass, low-metallicity AGB tracks
% 
% 2008: Marigo et al. (2008): Girardi et al. (2000) up to early-AGB + detailed TP-AGB from Marigo & Girardi (2007) (for M <= 7 Msun) + Bertelli et al. (1994) (for M > 7 Msun) + additional Z=0.0001 and Z=0.001 tracks.
% 
% 2010b: Marigo et al. (2008) with the Girardi et al. (2010) Case B correction for low-mass, low-metallicity AGB tracks
% 
% 2002: Basic set of Girardi et al. (2002) : Girardi et al. (2000) + simplified TP-AGB (for M <= 7 Msun) + Bertelli et al. (1994) (for M > 7 Msun) + additional Z=0.0001 and Z=0.001 tracks.


%% Photometric systems
%
% 2mass_spitzer: 2MASS + Spitzer (IRAC+MIPS)
% 
% 2mass_spitzer_wise: 2MASS + Spitzer (IRAC+MIPS) + WISE
% 
% 2mass: 2MASS JHKs
% 
% ubvrijhk: UBVRIJHK (cf. Maiz-Apellaniz 2006 + Bessell 1990)
% 
% bessell: UBVRIJHKLMN (cf. Bessell 1990 + Bessell & Brett 1988)
% 
% akari: AKARI
% 
% batc: BATC
% 
% megacam: CFHT/Megacam u g'r'i'z'
% 
% dcmc: DCMC
% 
% denis: DENIS
% 
% dmc14: DMC 14 filters
% 
% dmc15: DMC 15 filters
% 
% eis: ESO/EIS (WFI UBVRIZ + SOFI JHK)
% 
% wfi: ESO/WFI
% 
% wfi_sofi: ESO/WFI+SOFI
% 
% wfi2: ESO/WFI2
% 
% galex: GALEX FUV+NUV (Vegamag) + Johnson's UBV
% 
% galex_sloan: GALEX FUV+NUV + SDSS ugriz (all ABmags)
% 
% UVbright: HST+GALEX+Swift/UVOT UV filters
% 
% acs_hrc: HST/ACS HRC
% 
% acs_wfc: HST/ACS WFC
% 
% nicmosab: HST/NICMOS AB
% 
% nicmosst: HST/NICMOS ST
% 
% nicmosvega: HST/NICMOS vega
% 
% stis: HST/STIS imaging mode
% 
% wfc3ir: HST/WFC3 IR channel (final throughputs)
% 
% wfc3uvis1: HST/WFC3 UVIS channel, chip 1 (final throughputs)
% 
% wfc3uvis2: HST/WFC3 UVIS channel, chip 2 (final throughputs)
% 
% wfc3_medium: HST/WFC3 medium filters (UVIS1+IR, final throughputs)
% 
% wfc3: HST/WFC3 wide filters (UVIS1+IR, final throughputs)
% 
% wfpc2: HST/WFPC2 (Vegamag, cf. Holtzman et al. 1995)
% 
% kepler: Kepler + SDSS griz + DDO51 (in ABmags)
% 
% kepler_2mass: Kepler + SDSS griz + DDO51 (in ABmags) + 2MASS (~Vegamag)
% 
% ogle: OGLE-II
% 
% panstarrs1: Pan-STARRS1
% 
% sloan: SDSS ugriz
% 
% sloan_2mass: SDSS ugriz + 2MASS JHKs
% 
% sloan_ukidss: SDSS ugriz + UKIDSS ZYJHK
% 
% swift_uvot: SWIFT/UVOT UVW2, UVM2, UVW1,u (Vegamag)
% 
% spitzer: Spitzer IRAC+MIPS
% 
% stroemgren: Stroemgren-Crawford
% 
% suprimecam: Subaru/Suprime-Cam (ABmags)
% 
% tycho2: Tycho VTBT
% 
% ukidss: UKIDSS ZYJHK (Vegamag)
% 
% visir: VISIR
% 
% vista: VISTA ZYJHKs (Vegamag)
% 
% washington: Washington CMT1T2
% 
% washington_ddo51: Washington CMT1T2 + DDO51

