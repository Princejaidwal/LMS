<div class="mt-3 mb-3 status-card-cantainer">
	<div class="d-flex text-white align-items-center justify-content-around status-card">
		<div class="d-flex flex-column">
			<span class="fs-2 fw-bold"><%= totalLeadCount %> </span>
			<span>Total Leads</span>
		</div>
		<i class="fa fa-line-chart box-icon"></i>
	</div>
	<div class="d-flex text-white align-items-center justify-content-around status-card">
		<div class="d-flex flex-column">
			<span  class="fs-2 fw-bold"><%= userCount %></span>
			<span>All Users</span>
		</div>
		<i class="fa fa-users box-icon"></i>
	</div>
	<div class="d-flex text-white align-items-center justify-content-around status-card">
		<div class="d-flex flex-column">
			<span  class="fs-2 fw-bold"><%= totalLeadCountByAssigned %></span>
			<span>Assigned Leads</span>
		</div>
		<i class="fa fa-users box-icon"></i>
	</div>
	<div class="d-flex text-white align-items-center justify-content-around status-card">
		<div class="d-flex flex-column">
			<span  class="fs-2 fw-bold"><%= totalLeadCountByEnrolled %></span>
			<span>Enrolled Leads</span>
		</div>
		<i class="fa fa-users box-icon"></i>
	</div>
</div>